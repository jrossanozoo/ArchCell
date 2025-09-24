
define class Din_EntidadORDENDEPRODUCCIONAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_ORDENDEPRODUCCION'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( Numero, 12, 0)]
	cExpresionCCPorCampos = [str( #tabla#.Numero, 12, 0)]
	cTagClaveCandidata = '_OPPCC'
	cTagClavePk = '_OPPPK'
	cTablaPrincipal = 'ORDENPROD'
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
			local  lxOrdenprodFectrans, lxOrdenprodFecexpo, lxOrdenprodFmodifw, lxOrdenprodFaltafw, lxOrdenprodFecimpo, lxOrdenprodHaltafw, lxOrdenprodHoraexpo, lxOrdenprodHmodifw, lxOrdenprodHoraimpo, lxOrdenprodVmodifw, lxOrdenprodZadsfw, lxOrdenprodValtafw, lxOrdenprodUmodifw, lxOrdenprodSmodifw, lxOrdenprodUaltafw, lxOrdenprodSaltafw, lxOrdenprodBdmodifw, lxOrdenprodEsttrans, lxOrdenprodBdaltafw, lxOrdenprodCodigo, lxOrdenprodObs, lxOrdenprodNumero, lxOrdenprodDescrip, lxOrdenprodModelo, lxOrdenprodFfch, lxOrdenprodCurvaprod, lxOrdenprodNcantidad, lxOrdenprodProducto
				lxOrdenprodFectrans =  .Fechatransferencia			lxOrdenprodFecexpo =  .Fechaexpo			lxOrdenprodFmodifw =  .Fechamodificacionfw			lxOrdenprodFaltafw =  .Fechaaltafw			lxOrdenprodFecimpo =  .Fechaimpo			lxOrdenprodHaltafw =  .Horaaltafw			lxOrdenprodHoraexpo =  .Horaexpo			lxOrdenprodHmodifw =  .Horamodificacionfw			lxOrdenprodHoraimpo =  .Horaimpo			lxOrdenprodVmodifw =  .Versionmodificacionfw			lxOrdenprodZadsfw =  .Zadsfw			lxOrdenprodValtafw =  .Versionaltafw			lxOrdenprodUmodifw =  .Usuariomodificacionfw			lxOrdenprodSmodifw =  .Seriemodificacionfw			lxOrdenprodUaltafw =  .Usuarioaltafw			lxOrdenprodSaltafw =  .Seriealtafw			lxOrdenprodBdmodifw =  .Basededatosmodificacionfw			lxOrdenprodEsttrans =  .Estadotransferencia			lxOrdenprodBdaltafw =  .Basededatosaltafw			lxOrdenprodCodigo =  .Codigo			lxOrdenprodObs =  .Obs			lxOrdenprodNumero =  .Numero			lxOrdenprodDescrip =  .Descripcion			lxOrdenprodModelo =  upper( .Modelo_PK ) 			lxOrdenprodFfch =  .Fecha			lxOrdenprodCurvaprod =  upper( .CurvaDeProduccion_PK ) 			lxOrdenprodNcantidad =  .Cantidad			lxOrdenprodProducto =  upper( .ProductoFinal_PK ) 
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxOrdenprodCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.ORDENPROD ( "Fectrans","Fecexpo","Fmodifw","Faltafw","Fecimpo","Haltafw","Horaexpo","Hmodifw","Horaimpo","Vmodifw","Zadsfw","Valtafw","Umodifw","Smodifw","Ualtafw","Saltafw","Bdmodifw","Esttrans","Bdaltafw","Codigo","Obs","Numero","Descrip","Modelo","Ffch","Curvaprod","Ncantidad","Producto" ) values ( <<"'" + this.ConvertirDateSql( lxOrdenprodFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdenprodFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdenprodFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdenprodFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdenprodFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodObs ) + "'" >>, <<lxOrdenprodNumero >>, <<"'" + this.FormatearTextoSql( lxOrdenprodDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodModelo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdenprodFfch ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodCurvaprod ) + "'" >>, <<lxOrdenprodNcantidad >>, <<"'" + this.FormatearTextoSql( lxOrdenprodProducto ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria


			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenCurva
				if this.oEntidad.OrdenCurva.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProducto_PK = loItem.Producto_PK
					lxProductodetalle = loItem.Productodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxCantidad = loItem.Cantidad
					lxTotal = loItem.Total
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ORDPCURV("NROITEM","CodOrden","Producto","cProdDet","CodColor","CColTxt","CodTalle","CTalleTxt","CantCurva","CantTotal" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxProducto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProductodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<lxTotal>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenInsumos
				if this.oEntidad.OrdenInsumos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxColorm_PK = loItem.Colorm_PK
					lxColormdetalle = loItem.Colormdetalle
					lxTallem_PK = loItem.Tallem_PK
					lxTallemdetalle = loItem.Tallemdetalle
					lxInsumo_PK = loItem.Insumo_PK
					lxInsumodetalle = loItem.Insumodetalle
					lxColor_PK = loItem.Color_PK
					lxColororddet = loItem.Colororddet
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxUnidaddemedida_PK = loItem.Unidaddemedida_PK
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ORDPINS("NROITEM","CodOrden","Proceso","cColor","cColDet","cTalle","cTalleDet","Insumo","cInsDet","ICodColor","IColTxt","ICodTalle","ITalleTxt","UniMed","CantNec" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColororddet ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidaddemedida_PK ) + "'">>, <<lxCantidad>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenSalidas
				if this.oEntidad.OrdenSalidas.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
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
						Insert into ZooLogic.ORDPSAL("NROITEM","CodOrden","Proceso","cColor","cColDet","cTalle","cTalleDet","SemiElab","SemiDeta","iColor","IColDet","iTalle","ITalleDEt","Cantidad" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenProcesos
				if this.oEntidad.OrdenProcesos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxOrden = loItem.Orden
					lxTaller_PK = loItem.Taller_PK
					lxInventarioentrada_PK = loItem.Inventarioentrada_PK
					lxInventariosalida_PK = loItem.Inventariosalida_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ORDPPROC("NROITEM","CodOrden","Codigo","cProcDet","Orden","Taller","InvEnt","InvSal" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<lxOrden>>, <<"'" + this.FormatearTextoSql( lxTaller_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventarioentrada_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventariosalida_PK ) + "'">> ) 
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
			If this.ConsultarPorClaveCandidata()
				lcError  = 'El número a grabar ya existe. Cambie el último número del talonario correspondiente'
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
			local  lxOrdenprodFectrans, lxOrdenprodFecexpo, lxOrdenprodFmodifw, lxOrdenprodFaltafw, lxOrdenprodFecimpo, lxOrdenprodHaltafw, lxOrdenprodHoraexpo, lxOrdenprodHmodifw, lxOrdenprodHoraimpo, lxOrdenprodVmodifw, lxOrdenprodZadsfw, lxOrdenprodValtafw, lxOrdenprodUmodifw, lxOrdenprodSmodifw, lxOrdenprodUaltafw, lxOrdenprodSaltafw, lxOrdenprodBdmodifw, lxOrdenprodEsttrans, lxOrdenprodBdaltafw, lxOrdenprodCodigo, lxOrdenprodObs, lxOrdenprodNumero, lxOrdenprodDescrip, lxOrdenprodModelo, lxOrdenprodFfch, lxOrdenprodCurvaprod, lxOrdenprodNcantidad, lxOrdenprodProducto
				lxOrdenprodFectrans =  .Fechatransferencia			lxOrdenprodFecexpo =  .Fechaexpo			lxOrdenprodFmodifw =  .Fechamodificacionfw			lxOrdenprodFaltafw =  .Fechaaltafw			lxOrdenprodFecimpo =  .Fechaimpo			lxOrdenprodHaltafw =  .Horaaltafw			lxOrdenprodHoraexpo =  .Horaexpo			lxOrdenprodHmodifw =  .Horamodificacionfw			lxOrdenprodHoraimpo =  .Horaimpo			lxOrdenprodVmodifw =  .Versionmodificacionfw			lxOrdenprodZadsfw =  .Zadsfw			lxOrdenprodValtafw =  .Versionaltafw			lxOrdenprodUmodifw =  .Usuariomodificacionfw			lxOrdenprodSmodifw =  .Seriemodificacionfw			lxOrdenprodUaltafw =  .Usuarioaltafw			lxOrdenprodSaltafw =  .Seriealtafw			lxOrdenprodBdmodifw =  .Basededatosmodificacionfw			lxOrdenprodEsttrans =  .Estadotransferencia			lxOrdenprodBdaltafw =  .Basededatosaltafw			lxOrdenprodCodigo =  .Codigo			lxOrdenprodObs =  .Obs			lxOrdenprodNumero =  .Numero			lxOrdenprodDescrip =  .Descripcion			lxOrdenprodModelo =  upper( .Modelo_PK ) 			lxOrdenprodFfch =  .Fecha			lxOrdenprodCurvaprod =  upper( .CurvaDeProduccion_PK ) 			lxOrdenprodNcantidad =  .Cantidad			lxOrdenprodProducto =  upper( .ProductoFinal_PK ) 
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.ORDENPROD set "Fectrans" = <<"'" + this.ConvertirDateSql( lxOrdenprodFectrans ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxOrdenprodFecexpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxOrdenprodFmodifw ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxOrdenprodFaltafw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxOrdenprodFecimpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxOrdenprodHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxOrdenprodHoraexpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxOrdenprodHmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxOrdenprodHoraimpo ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxOrdenprodVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxOrdenprodZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxOrdenprodValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxOrdenprodUmodifw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxOrdenprodSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxOrdenprodUaltafw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxOrdenprodSaltafw ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxOrdenprodBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxOrdenprodEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxOrdenprodBdaltafw ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxOrdenprodCodigo ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxOrdenprodObs ) + "'">>,"Numero" = <<lxOrdenprodNumero>>,"Descrip" = <<"'" + this.FormatearTextoSql( lxOrdenprodDescrip ) + "'">>,"Modelo" = <<"'" + this.FormatearTextoSql( lxOrdenprodModelo ) + "'">>,"Ffch" = <<"'" + this.ConvertirDateSql( lxOrdenprodFfch ) + "'">>,"Curvaprod" = <<"'" + this.FormatearTextoSql( lxOrdenprodCurvaprod ) + "'">>,"Ncantidad" = <<lxOrdenprodNcantidad>>,"Producto" = <<"'" + this.FormatearTextoSql( lxOrdenprodProducto ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxOrdenprodCodigo ) + "'">> and  ORDENPROD.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ORDPCURV where "CodOrden" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ORDPINS where "CodOrden" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ORDPSAL where "CodOrden" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ORDPPROC where "CodOrden" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenCurva
				if this.oEntidad.OrdenCurva.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProducto_PK = loItem.Producto_PK
					lxProductodetalle = loItem.Productodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxCantidad = loItem.Cantidad
					lxTotal = loItem.Total
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ORDPCURV("NROITEM","CodOrden","Producto","cProdDet","CodColor","CColTxt","CodTalle","CTalleTxt","CantCurva","CantTotal" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxProducto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProductodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<lxTotal>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenInsumos
				if this.oEntidad.OrdenInsumos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxColorm_PK = loItem.Colorm_PK
					lxColormdetalle = loItem.Colormdetalle
					lxTallem_PK = loItem.Tallem_PK
					lxTallemdetalle = loItem.Tallemdetalle
					lxInsumo_PK = loItem.Insumo_PK
					lxInsumodetalle = loItem.Insumodetalle
					lxColor_PK = loItem.Color_PK
					lxColororddet = loItem.Colororddet
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxUnidaddemedida_PK = loItem.Unidaddemedida_PK
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ORDPINS("NROITEM","CodOrden","Proceso","cColor","cColDet","cTalle","cTalleDet","Insumo","cInsDet","ICodColor","IColTxt","ICodTalle","ITalleTxt","UniMed","CantNec" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColororddet ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidaddemedida_PK ) + "'">>, <<lxCantidad>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenSalidas
				if this.oEntidad.OrdenSalidas.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
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
						Insert into ZooLogic.ORDPSAL("NROITEM","CodOrden","Proceso","cColor","cColDet","cTalle","cTalleDet","SemiElab","SemiDeta","iColor","IColDet","iTalle","ITalleDEt","Cantidad" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenProcesos
				if this.oEntidad.OrdenProcesos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxOrden = loItem.Orden
					lxTaller_PK = loItem.Taller_PK
					lxInventarioentrada_PK = loItem.Inventarioentrada_PK
					lxInventariosalida_PK = loItem.Inventariosalida_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ORDPPROC("NROITEM","CodOrden","Codigo","cProcDet","Orden","Taller","InvEnt","InvSal" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<lxOrden>>, <<"'" + this.FormatearTextoSql( lxTaller_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventarioentrada_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventariosalida_PK ) + "'">> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 Codigo from ZooLogic.ORDENPROD where " + this.ConvertirFuncionesSql( " ORDENPROD.CODIGO != ''" ) )
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
			Local lxOrdenprodCodigo
			lxOrdenprodCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Obs" as "Obs", "Numero" as "Numero", "Descrip" as "Descripcion", "Modelo" as "Modelo", "Ffch" as "Fecha", "Curvaprod" as "Curvadeproduccion", "Ncantidad" as "Cantidad", "Producto" as "Productofinal" from ZooLogic.ORDENPROD where "Codigo" = <<"'" + this.FormatearTextoSql( lxOrdenprodCodigo ) + "'">> and  ORDENPROD.CODIGO != ''
			endtext
			use in select('c_ORDENDEPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ORDENDEPRODUCCION', set( 'Datasession' ) )

			if reccount( 'c_ORDENDEPRODUCCION' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codorden" as "Codigoorden", "Producto" as "Producto", "Cproddet" as "Productodetalle", "Codcolor" as "Color", "Ccoltxt" as "Colordetalle", "Codtalle" as "Talle", "Ctalletxt" as "Talledetalle", "Cantcurva" as "Cantidad", "Canttotal" as "Total" from ZooLogic.ORDPCURV where CodOrden = <<"'" + this.FormatearTextoSql( c_ORDENDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenCurva')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenCurva', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenCurva
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codorden" as "Codigoorden", "Proceso" as "Proceso", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Cinsdet" as "Insumodetalle", "Icodcolor" as "Color", "Icoltxt" as "Colororddet", "Icodtalle" as "Talle", "Italletxt" as "Talledetalle", "Unimed" as "Unidaddemedida", "Cantnec" as "Cantidad" from ZooLogic.ORDPINS where CodOrden = <<"'" + this.FormatearTextoSql( c_ORDENDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codorden" as "Codigoorden", "Proceso" as "Proceso", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Icolor" as "Color", "Icoldet" as "Colordetalle", "Italle" as "Talle", "Italledet" as "Talledetalle", "Cantidad" as "Cantidad" from ZooLogic.ORDPSAL where CodOrden = <<"'" + this.FormatearTextoSql( c_ORDENDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenSalidas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenSalidas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenSalidas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codorden" as "Codigoorden", "Codigo" as "Proceso", "Cprocdet" as "Procesodetalle", "Orden" as "Orden", "Taller" as "Taller", "Invent" as "Inventarioentrada", "Invsal" as "Inventariosalida" from ZooLogic.ORDPPROC where CodOrden = <<"'" + this.FormatearTextoSql( c_ORDENDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenProcesos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenProcesos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenProcesos
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxORDENPRODNumero As Variant
			lxORDENPRODNumero = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Obs" as "Obs", "Numero" as "Numero", "Descrip" as "Descripcion", "Modelo" as "Modelo", "Ffch" as "Fecha", "Curvaprod" as "Curvadeproduccion", "Ncantidad" as "Cantidad", "Producto" as "Productofinal" from ZooLogic.ORDENPROD where  ORDENPROD.CODIGO != '' And Numero = <<lxORDENPRODNumero>>
			endtext
			use in select('c_ORDENDEPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ORDENDEPRODUCCION', set( 'Datasession' ) )
			if reccount( 'c_ORDENDEPRODUCCION' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codorden" as "Codigoorden", "Producto" as "Producto", "Cproddet" as "Productodetalle", "Codcolor" as "Color", "Ccoltxt" as "Colordetalle", "Codtalle" as "Talle", "Ctalletxt" as "Talledetalle", "Cantcurva" as "Cantidad", "Canttotal" as "Total" from ZooLogic.ORDPCURV where CodOrden = <<"'" + this.FormatearTextoSql( c_ORDENDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenCurva')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenCurva', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenCurva
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codorden" as "Codigoorden", "Proceso" as "Proceso", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Cinsdet" as "Insumodetalle", "Icodcolor" as "Color", "Icoltxt" as "Colororddet", "Icodtalle" as "Talle", "Italletxt" as "Talledetalle", "Unimed" as "Unidaddemedida", "Cantnec" as "Cantidad" from ZooLogic.ORDPINS where CodOrden = <<"'" + this.FormatearTextoSql( c_ORDENDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codorden" as "Codigoorden", "Proceso" as "Proceso", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Icolor" as "Color", "Icoldet" as "Colordetalle", "Italle" as "Talle", "Italledet" as "Talledetalle", "Cantidad" as "Cantidad" from ZooLogic.ORDPSAL where CodOrden = <<"'" + this.FormatearTextoSql( c_ORDENDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenSalidas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenSalidas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenSalidas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codorden" as "Codigoorden", "Codigo" as "Proceso", "Cprocdet" as "Procesodetalle", "Orden" as "Orden", "Taller" as "Taller", "Invent" as "Inventarioentrada", "Invsal" as "Inventariosalida" from ZooLogic.ORDPPROC where CodOrden = <<"'" + this.FormatearTextoSql( c_ORDENDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenProcesos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenProcesos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenProcesos
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxOrdenprodCodigo as Variant
		llRetorno = .t.
		lxOrdenprodCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.ORDENPROD where "Codigo" = <<"'" + this.FormatearTextoSql( lxOrdenprodCodigo ) + "'">> and  ORDENPROD.CODIGO != ''
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
				lcOrden =  str( .Numero, 12, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Obs" as "Obs", "Numero" as "Numero", "Descrip" as "Descripcion", "Modelo" as "Modelo", "Ffch" as "Fecha", "Curvaprod" as "Curvadeproduccion", "Ncantidad" as "Cantidad", "Producto" as "Productofinal" from ZooLogic.ORDENPROD where  ORDENPROD.CODIGO != '' order by Numero
			endtext
			use in select('c_ORDENDEPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ORDENDEPRODUCCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codorden" as "Codigoorden", "Producto" as "Producto", "Cproddet" as "Productodetalle", "Codcolor" as "Color", "Ccoltxt" as "Colordetalle", "Codtalle" as "Talle", "Ctalletxt" as "Talledetalle", "Cantcurva" as "Cantidad", "Canttotal" as "Total" from ZooLogic.ORDPCURV where CodOrden = <<"'" + this.FormatearTextoSql( c_ORDENDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenCurva')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenCurva', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenCurva
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codorden" as "Codigoorden", "Proceso" as "Proceso", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Cinsdet" as "Insumodetalle", "Icodcolor" as "Color", "Icoltxt" as "Colororddet", "Icodtalle" as "Talle", "Italletxt" as "Talledetalle", "Unimed" as "Unidaddemedida", "Cantnec" as "Cantidad" from ZooLogic.ORDPINS where CodOrden = <<"'" + this.FormatearTextoSql( c_ORDENDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codorden" as "Codigoorden", "Proceso" as "Proceso", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Icolor" as "Color", "Icoldet" as "Colordetalle", "Italle" as "Talle", "Italledet" as "Talledetalle", "Cantidad" as "Cantidad" from ZooLogic.ORDPSAL where CodOrden = <<"'" + this.FormatearTextoSql( c_ORDENDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenSalidas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenSalidas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenSalidas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codorden" as "Codigoorden", "Codigo" as "Proceso", "Cprocdet" as "Procesodetalle", "Orden" as "Orden", "Taller" as "Taller", "Invent" as "Inventarioentrada", "Invsal" as "Inventariosalida" from ZooLogic.ORDPPROC where CodOrden = <<"'" + this.FormatearTextoSql( c_ORDENDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenProcesos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenProcesos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenProcesos
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
				lcOrden =  str( .Numero, 12, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Obs" as "Obs", "Numero" as "Numero", "Descrip" as "Descripcion", "Modelo" as "Modelo", "Ffch" as "Fecha", "Curvaprod" as "Curvadeproduccion", "Ncantidad" as "Cantidad", "Producto" as "Productofinal" from ZooLogic.ORDENPROD where  str( Numero, 12, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ORDENPROD.CODIGO != '' order by Numero
			endtext
			use in select('c_ORDENDEPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ORDENDEPRODUCCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codorden" as "Codigoorden", "Producto" as "Producto", "Cproddet" as "Productodetalle", "Codcolor" as "Color", "Ccoltxt" as "Colordetalle", "Codtalle" as "Talle", "Ctalletxt" as "Talledetalle", "Cantcurva" as "Cantidad", "Canttotal" as "Total" from ZooLogic.ORDPCURV where CodOrden = <<"'" + this.FormatearTextoSql( c_ORDENDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenCurva')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenCurva', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenCurva
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codorden" as "Codigoorden", "Proceso" as "Proceso", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Cinsdet" as "Insumodetalle", "Icodcolor" as "Color", "Icoltxt" as "Colororddet", "Icodtalle" as "Talle", "Italletxt" as "Talledetalle", "Unimed" as "Unidaddemedida", "Cantnec" as "Cantidad" from ZooLogic.ORDPINS where CodOrden = <<"'" + this.FormatearTextoSql( c_ORDENDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codorden" as "Codigoorden", "Proceso" as "Proceso", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Icolor" as "Color", "Icoldet" as "Colordetalle", "Italle" as "Talle", "Italledet" as "Talledetalle", "Cantidad" as "Cantidad" from ZooLogic.ORDPSAL where CodOrden = <<"'" + this.FormatearTextoSql( c_ORDENDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenSalidas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenSalidas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenSalidas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codorden" as "Codigoorden", "Codigo" as "Proceso", "Cprocdet" as "Procesodetalle", "Orden" as "Orden", "Taller" as "Taller", "Invent" as "Inventarioentrada", "Invsal" as "Inventariosalida" from ZooLogic.ORDPPROC where CodOrden = <<"'" + this.FormatearTextoSql( c_ORDENDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenProcesos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenProcesos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenProcesos
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
				lcOrden =  str( .Numero, 12, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Obs" as "Obs", "Numero" as "Numero", "Descrip" as "Descripcion", "Modelo" as "Modelo", "Ffch" as "Fecha", "Curvaprod" as "Curvadeproduccion", "Ncantidad" as "Cantidad", "Producto" as "Productofinal" from ZooLogic.ORDENPROD where  str( Numero, 12, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  ORDENPROD.CODIGO != '' order by Numero desc
			endtext
			use in select('c_ORDENDEPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ORDENDEPRODUCCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codorden" as "Codigoorden", "Producto" as "Producto", "Cproddet" as "Productodetalle", "Codcolor" as "Color", "Ccoltxt" as "Colordetalle", "Codtalle" as "Talle", "Ctalletxt" as "Talledetalle", "Cantcurva" as "Cantidad", "Canttotal" as "Total" from ZooLogic.ORDPCURV where CodOrden = <<"'" + this.FormatearTextoSql( c_ORDENDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenCurva')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenCurva', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenCurva
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codorden" as "Codigoorden", "Proceso" as "Proceso", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Cinsdet" as "Insumodetalle", "Icodcolor" as "Color", "Icoltxt" as "Colororddet", "Icodtalle" as "Talle", "Italletxt" as "Talledetalle", "Unimed" as "Unidaddemedida", "Cantnec" as "Cantidad" from ZooLogic.ORDPINS where CodOrden = <<"'" + this.FormatearTextoSql( c_ORDENDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codorden" as "Codigoorden", "Proceso" as "Proceso", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Icolor" as "Color", "Icoldet" as "Colordetalle", "Italle" as "Talle", "Italledet" as "Talledetalle", "Cantidad" as "Cantidad" from ZooLogic.ORDPSAL where CodOrden = <<"'" + this.FormatearTextoSql( c_ORDENDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenSalidas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenSalidas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenSalidas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codorden" as "Codigoorden", "Codigo" as "Proceso", "Cprocdet" as "Procesodetalle", "Orden" as "Orden", "Taller" as "Taller", "Invent" as "Inventarioentrada", "Invsal" as "Inventariosalida" from ZooLogic.ORDPPROC where CodOrden = <<"'" + this.FormatearTextoSql( c_ORDENDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenProcesos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenProcesos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenProcesos
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
				lcOrden =  str( .Numero, 12, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Obs" as "Obs", "Numero" as "Numero", "Descrip" as "Descripcion", "Modelo" as "Modelo", "Ffch" as "Fecha", "Curvaprod" as "Curvadeproduccion", "Ncantidad" as "Cantidad", "Producto" as "Productofinal" from ZooLogic.ORDENPROD where  ORDENPROD.CODIGO != '' order by Numero desc
			endtext
			use in select('c_ORDENDEPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_ORDENDEPRODUCCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codorden" as "Codigoorden", "Producto" as "Producto", "Cproddet" as "Productodetalle", "Codcolor" as "Color", "Ccoltxt" as "Colordetalle", "Codtalle" as "Talle", "Ctalletxt" as "Talledetalle", "Cantcurva" as "Cantidad", "Canttotal" as "Total" from ZooLogic.ORDPCURV where CodOrden = <<"'" + this.FormatearTextoSql( c_ORDENDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenCurva')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenCurva', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenCurva
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codorden" as "Codigoorden", "Proceso" as "Proceso", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Cinsdet" as "Insumodetalle", "Icodcolor" as "Color", "Icoltxt" as "Colororddet", "Icodtalle" as "Talle", "Italletxt" as "Talledetalle", "Unimed" as "Unidaddemedida", "Cantnec" as "Cantidad" from ZooLogic.ORDPINS where CodOrden = <<"'" + this.FormatearTextoSql( c_ORDENDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codorden" as "Codigoorden", "Proceso" as "Proceso", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Icolor" as "Color", "Icoldet" as "Colordetalle", "Italle" as "Talle", "Italledet" as "Talledetalle", "Cantidad" as "Cantidad" from ZooLogic.ORDPSAL where CodOrden = <<"'" + this.FormatearTextoSql( c_ORDENDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenSalidas')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenSalidas', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenSalidas
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codorden" as "Codigoorden", "Codigo" as "Proceso", "Cprocdet" as "Procesodetalle", "Orden" as "Orden", "Taller" as "Taller", "Invent" as "Inventarioentrada", "Invsal" as "Inventariosalida" from ZooLogic.ORDPPROC where CodOrden = <<"'" + this.FormatearTextoSql( c_ORDENDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_OrdenProcesos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_OrdenProcesos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_OrdenProcesos
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
			lcXml = this.oConexion.EjecutarSql( "select Fectrans,Fecexpo,Fmodifw,Faltafw,Fecimpo,Haltafw,Horaexpo,Hmodifw,Horaimpo,Vmodifw,Zadsfw,Va" + ;
"ltafw,Umodifw,Smodifw,Ualtafw,Saltafw,Bdmodifw,Esttrans,Bdaltafw,Codigo,Obs,Numero,Descrip,Modelo,Ff" + ;
"ch,Curvaprod,Ncantidad,Producto" + ;
" from ZooLogic.ORDENPROD where  ORDENPROD.CODIGO != '' and " + lcFiltro )
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
			local  lxOrdenprodFectrans, lxOrdenprodFecexpo, lxOrdenprodFmodifw, lxOrdenprodFaltafw, lxOrdenprodFecimpo, lxOrdenprodHaltafw, lxOrdenprodHoraexpo, lxOrdenprodHmodifw, lxOrdenprodHoraimpo, lxOrdenprodVmodifw, lxOrdenprodZadsfw, lxOrdenprodValtafw, lxOrdenprodUmodifw, lxOrdenprodSmodifw, lxOrdenprodUaltafw, lxOrdenprodSaltafw, lxOrdenprodBdmodifw, lxOrdenprodEsttrans, lxOrdenprodBdaltafw, lxOrdenprodCodigo, lxOrdenprodObs, lxOrdenprodNumero, lxOrdenprodDescrip, lxOrdenprodModelo, lxOrdenprodFfch, lxOrdenprodCurvaprod, lxOrdenprodNcantidad, lxOrdenprodProducto
				lxOrdenprodFectrans = ctod( '  /  /    ' )			lxOrdenprodFecexpo = ctod( '  /  /    ' )			lxOrdenprodFmodifw = ctod( '  /  /    ' )			lxOrdenprodFaltafw = ctod( '  /  /    ' )			lxOrdenprodFecimpo = ctod( '  /  /    ' )			lxOrdenprodHaltafw = []			lxOrdenprodHoraexpo = []			lxOrdenprodHmodifw = []			lxOrdenprodHoraimpo = []			lxOrdenprodVmodifw = []			lxOrdenprodZadsfw = []			lxOrdenprodValtafw = []			lxOrdenprodUmodifw = []			lxOrdenprodSmodifw = []			lxOrdenprodUaltafw = []			lxOrdenprodSaltafw = []			lxOrdenprodBdmodifw = []			lxOrdenprodEsttrans = []			lxOrdenprodBdaltafw = []			lxOrdenprodCodigo = []			lxOrdenprodObs = []			lxOrdenprodNumero = 0			lxOrdenprodDescrip = []			lxOrdenprodModelo = []			lxOrdenprodFfch = ctod( '  /  /    ' )			lxOrdenprodCurvaprod = []			lxOrdenprodNcantidad = 0			lxOrdenprodProducto = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ORDPCURV where "CodOrden" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ORDPINS where "CodOrden" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ORDPSAL where "CodOrden" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.ORDPPROC where "CodOrden" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.ORDENPROD where "Codigo" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'ORDENPROD' + '_' + tcCampo
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
		lcWhere = " Where  ORDENPROD.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Obs" as "Obs", "Numero" as "Numero", "Descrip" as "Descripcion", "Modelo" as "Modelo", "Ffch" as "Fecha", "Curvaprod" as "Curvadeproduccion", "Ncantidad" as "Cantidad", "Producto" as "Productofinal"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ORDENPROD', '', tnTope )
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
	Function ObtenerDatosDetalleOrdenCurva( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  ORDPCURV.CODORDEN != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codorden" as "Codigoorden", "Producto" as "Producto", "Cproddet" as "Productodetalle", "Codcolor" as "Color", "Ccoltxt" as "Colordetalle", "Codtalle" as "Talle", "Ctalletxt" as "Talledetalle", "Cantcurva" as "Cantidad", "Canttotal" as "Total"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleOrdenCurva( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ORDPCURV', 'OrdenCurva', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleOrdenCurva( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleOrdenCurva( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleOrdenInsumos( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  ORDPINS.CODORDEN != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codorden" as "Codigoorden", "Proceso" as "Proceso", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Cinsdet" as "Insumodetalle", "Icodcolor" as "Color", "Icoltxt" as "Colororddet", "Icodtalle" as "Talle", "Italletxt" as "Talledetalle", "Unimed" as "Unidaddemedida", "Cantnec" as "Cantidad"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleOrdenInsumos( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ORDPINS', 'OrdenInsumos', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleOrdenInsumos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleOrdenInsumos( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleOrdenSalidas( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  ORDPSAL.CODORDEN != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codorden" as "Codigoorden", "Proceso" as "Proceso", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Semielab" as "Semielaborado", "Semideta" as "Semielaboradodetalle", "Icolor" as "Color", "Icoldet" as "Colordetalle", "Italle" as "Talle", "Italledet" as "Talledetalle", "Cantidad" as "Cantidad"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleOrdenSalidas( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ORDPSAL', 'OrdenSalidas', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleOrdenSalidas( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleOrdenSalidas( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleOrdenProcesos( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  ORDPPROC.CODORDEN != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codorden" as "Codigoorden", "Codigo" as "Proceso", "Cprocdet" as "Procesodetalle", "Orden" as "Orden", "Taller" as "Taller", "Invent" as "Inventarioentrada", "Invsal" as "Inventariosalida"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleOrdenProcesos( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'ORDPPROC', 'OrdenProcesos', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleOrdenProcesos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleOrdenProcesos( lcAtributo )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
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
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'MODELO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MODELO AS MODELO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCH AS FECHA'
				Case lcAtributo == 'CURVADEPRODUCCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CURVAPROD AS CURVADEPRODUCCION'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NCANTIDAD AS CANTIDAD'
				Case lcAtributo == 'PRODUCTOFINAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRODUCTO AS PRODUCTOFINAL'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleOrdenCurva( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGOORDEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODORDEN AS CODIGOORDEN'
				Case lcAtributo == 'PRODUCTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PRODUCTO AS PRODUCTO'
				Case lcAtributo == 'PRODUCTODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CPRODDET AS PRODUCTODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCOLOR AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CCOLTXT AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODTALLE AS TALLE'
				Case lcAtributo == 'TALLEDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CTALLETXT AS TALLEDETALLE'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTCURVA AS CANTIDAD'
				Case lcAtributo == 'TOTAL'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTTOTAL AS TOTAL'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleOrdenInsumos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGOORDEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODORDEN AS CODIGOORDEN'
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
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CINSDET AS INSUMODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ICODCOLOR AS COLOR'
				Case lcAtributo == 'COLORORDDET'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ICOLTXT AS COLORORDDET'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ICODTALLE AS TALLE'
				Case lcAtributo == 'TALLEDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ITALLETXT AS TALLEDETALLE'
				Case lcAtributo == 'UNIDADDEMEDIDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UNIMED AS UNIDADDEMEDIDA'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTNEC AS CANTIDAD'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleOrdenSalidas( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGOORDEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODORDEN AS CODIGOORDEN'
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
	Function ObtenerCamposSelectDetalleOrdenProcesos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGOORDEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODORDEN AS CODIGOORDEN'
				Case lcAtributo == 'PROCESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS PROCESO'
				Case lcAtributo == 'PROCESODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CPROCDET AS PROCESODETALLE'
				Case lcAtributo == 'ORDEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORDEN AS ORDEN'
				Case lcAtributo == 'TALLER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLER AS TALLER'
				Case lcAtributo == 'INVENTARIOENTRADA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INVENT AS INVENTARIOENTRADA'
				Case lcAtributo == 'INVENTARIOSALIDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INVSAL AS INVENTARIOSALIDA'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoEntidad( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
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
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'MODELO'
				lcCampo = 'MODELO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FFCH'
			Case upper( alltrim( tcAtributo ) ) == 'CURVADEPRODUCCION'
				lcCampo = 'CURVAPROD'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'NCANTIDAD'
			Case upper( alltrim( tcAtributo ) ) == 'PRODUCTOFINAL'
				lcCampo = 'PRODUCTO'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleOrdenCurva( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOORDEN'
				lcCampo = 'CODORDEN'
			Case upper( alltrim( tcAtributo ) ) == 'PRODUCTO'
				lcCampo = 'PRODUCTO'
			Case upper( alltrim( tcAtributo ) ) == 'PRODUCTODETALLE'
				lcCampo = 'CPRODDET'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'CODCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'CCOLTXT'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'CODTALLE'
			Case upper( alltrim( tcAtributo ) ) == 'TALLEDETALLE'
				lcCampo = 'CTALLETXT'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'CANTCURVA'
			Case upper( alltrim( tcAtributo ) ) == 'TOTAL'
				lcCampo = 'CANTTOTAL'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleOrdenInsumos( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOORDEN'
				lcCampo = 'CODORDEN'
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
				lcCampo = 'CINSDET'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'ICODCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'COLORORDDET'
				lcCampo = 'ICOLTXT'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'ICODTALLE'
			Case upper( alltrim( tcAtributo ) ) == 'TALLEDETALLE'
				lcCampo = 'ITALLETXT'
			Case upper( alltrim( tcAtributo ) ) == 'UNIDADDEMEDIDA'
				lcCampo = 'UNIMED'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'CANTNEC'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleOrdenSalidas( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOORDEN'
				lcCampo = 'CODORDEN'
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
	Function ObtenerCampoDetalleOrdenProcesos( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGOORDEN'
				lcCampo = 'CODORDEN'
			Case upper( alltrim( tcAtributo ) ) == 'PROCESO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'PROCESODETALLE'
				lcCampo = 'CPROCDET'
			Case upper( alltrim( tcAtributo ) ) == 'ORDEN'
				lcCampo = 'ORDEN'
			Case upper( alltrim( tcAtributo ) ) == 'TALLER'
				lcCampo = 'TALLER'
			Case upper( alltrim( tcAtributo ) ) == 'INVENTARIOENTRADA'
				lcCampo = 'INVENT'
			Case upper( alltrim( tcAtributo ) ) == 'INVENTARIOSALIDA'
				lcCampo = 'INVSAL'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'ORDENCURVA'
			lcRetorno = 'ORDPCURV'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'ORDENINSUMOS'
			lcRetorno = 'ORDPINS'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'ORDENSALIDAS'
			lcRetorno = 'ORDPSAL'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'ORDENPROCESOS'
			lcRetorno = 'ORDPPROC'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxOrdenprodFectrans, lxOrdenprodFecexpo, lxOrdenprodFmodifw, lxOrdenprodFaltafw, lxOrdenprodFecimpo, lxOrdenprodHaltafw, lxOrdenprodHoraexpo, lxOrdenprodHmodifw, lxOrdenprodHoraimpo, lxOrdenprodVmodifw, lxOrdenprodZadsfw, lxOrdenprodValtafw, lxOrdenprodUmodifw, lxOrdenprodSmodifw, lxOrdenprodUaltafw, lxOrdenprodSaltafw, lxOrdenprodBdmodifw, lxOrdenprodEsttrans, lxOrdenprodBdaltafw, lxOrdenprodCodigo, lxOrdenprodObs, lxOrdenprodNumero, lxOrdenprodDescrip, lxOrdenprodModelo, lxOrdenprodFfch, lxOrdenprodCurvaprod, lxOrdenprodNcantidad, lxOrdenprodProducto
				lxOrdenprodFectrans =  .Fechatransferencia			lxOrdenprodFecexpo =  .Fechaexpo			lxOrdenprodFmodifw =  .Fechamodificacionfw			lxOrdenprodFaltafw =  .Fechaaltafw			lxOrdenprodFecimpo =  .Fechaimpo			lxOrdenprodHaltafw =  .Horaaltafw			lxOrdenprodHoraexpo =  .Horaexpo			lxOrdenprodHmodifw =  .Horamodificacionfw			lxOrdenprodHoraimpo =  .Horaimpo			lxOrdenprodVmodifw =  .Versionmodificacionfw			lxOrdenprodZadsfw =  .Zadsfw			lxOrdenprodValtafw =  .Versionaltafw			lxOrdenprodUmodifw =  .Usuariomodificacionfw			lxOrdenprodSmodifw =  .Seriemodificacionfw			lxOrdenprodUaltafw =  .Usuarioaltafw			lxOrdenprodSaltafw =  .Seriealtafw			lxOrdenprodBdmodifw =  .Basededatosmodificacionfw			lxOrdenprodEsttrans =  .Estadotransferencia			lxOrdenprodBdaltafw =  .Basededatosaltafw			lxOrdenprodCodigo =  .Codigo			lxOrdenprodObs =  .Obs			lxOrdenprodNumero =  .Numero			lxOrdenprodDescrip =  .Descripcion			lxOrdenprodModelo =  upper( .Modelo_PK ) 			lxOrdenprodFfch =  .Fecha			lxOrdenprodCurvaprod =  upper( .CurvaDeProduccion_PK ) 			lxOrdenprodNcantidad =  .Cantidad			lxOrdenprodProducto =  upper( .ProductoFinal_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.ORDENPROD ( "Fectrans","Fecexpo","Fmodifw","Faltafw","Fecimpo","Haltafw","Horaexpo","Hmodifw","Horaimpo","Vmodifw","Zadsfw","Valtafw","Umodifw","Smodifw","Ualtafw","Saltafw","Bdmodifw","Esttrans","Bdaltafw","Codigo","Obs","Numero","Descrip","Modelo","Ffch","Curvaprod","Ncantidad","Producto" ) values ( <<"'" + this.ConvertirDateSql( lxOrdenprodFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdenprodFecexpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdenprodFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdenprodFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdenprodFecimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodObs ) + "'" >>, <<lxOrdenprodNumero >>, <<"'" + this.FormatearTextoSql( lxOrdenprodDescrip ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodModelo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxOrdenprodFfch ) + "'" >>, <<"'" + this.FormatearTextoSql( lxOrdenprodCurvaprod ) + "'" >>, <<lxOrdenprodNcantidad >>, <<"'" + this.FormatearTextoSql( lxOrdenprodProducto ) + "'" >> )
		endtext
		loColeccion.cTabla = 'ORDENPROD' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenCurva
				if this.oEntidad.OrdenCurva.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProducto_PK = loItem.Producto_PK
					lxProductodetalle = loItem.Productodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxCantidad = loItem.Cantidad
					lxTotal = loItem.Total
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ORDPCURV("NROITEM","CodOrden","Producto","cProdDet","CodColor","CColTxt","CodTalle","CTalleTxt","CantCurva","CantTotal" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxProducto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProductodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<lxTotal>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenInsumos
				if this.oEntidad.OrdenInsumos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxColorm_PK = loItem.Colorm_PK
					lxColormdetalle = loItem.Colormdetalle
					lxTallem_PK = loItem.Tallem_PK
					lxTallemdetalle = loItem.Tallemdetalle
					lxInsumo_PK = loItem.Insumo_PK
					lxInsumodetalle = loItem.Insumodetalle
					lxColor_PK = loItem.Color_PK
					lxColororddet = loItem.Colororddet
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxUnidaddemedida_PK = loItem.Unidaddemedida_PK
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ORDPINS("NROITEM","CodOrden","Proceso","cColor","cColDet","cTalle","cTalleDet","Insumo","cInsDet","ICodColor","IColTxt","ICodTalle","ITalleTxt","UniMed","CantNec" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColororddet ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidaddemedida_PK ) + "'">>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenSalidas
				if this.oEntidad.OrdenSalidas.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
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
						Insert into ZooLogic.ORDPSAL("NROITEM","CodOrden","Proceso","cColor","cColDet","cTalle","cTalleDet","SemiElab","SemiDeta","iColor","IColDet","iTalle","ITalleDEt","Cantidad" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenProcesos
				if this.oEntidad.OrdenProcesos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxOrden = loItem.Orden
					lxTaller_PK = loItem.Taller_PK
					lxInventarioentrada_PK = loItem.Inventarioentrada_PK
					lxInventariosalida_PK = loItem.Inventariosalida_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ORDPPROC("NROITEM","CodOrden","Codigo","cProcDet","Orden","Taller","InvEnt","InvSal" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<lxOrden>>, <<"'" + this.FormatearTextoSql( lxTaller_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventarioentrada_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventariosalida_PK ) + "'">> ) 
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
			local  lxOrdenprodFectrans, lxOrdenprodFecexpo, lxOrdenprodFmodifw, lxOrdenprodFaltafw, lxOrdenprodFecimpo, lxOrdenprodHaltafw, lxOrdenprodHoraexpo, lxOrdenprodHmodifw, lxOrdenprodHoraimpo, lxOrdenprodVmodifw, lxOrdenprodZadsfw, lxOrdenprodValtafw, lxOrdenprodUmodifw, lxOrdenprodSmodifw, lxOrdenprodUaltafw, lxOrdenprodSaltafw, lxOrdenprodBdmodifw, lxOrdenprodEsttrans, lxOrdenprodBdaltafw, lxOrdenprodCodigo, lxOrdenprodObs, lxOrdenprodNumero, lxOrdenprodDescrip, lxOrdenprodModelo, lxOrdenprodFfch, lxOrdenprodCurvaprod, lxOrdenprodNcantidad, lxOrdenprodProducto
				lxOrdenprodFectrans =  .Fechatransferencia			lxOrdenprodFecexpo =  .Fechaexpo			lxOrdenprodFmodifw =  .Fechamodificacionfw			lxOrdenprodFaltafw =  .Fechaaltafw			lxOrdenprodFecimpo =  .Fechaimpo			lxOrdenprodHaltafw =  .Horaaltafw			lxOrdenprodHoraexpo =  .Horaexpo			lxOrdenprodHmodifw =  .Horamodificacionfw			lxOrdenprodHoraimpo =  .Horaimpo			lxOrdenprodVmodifw =  .Versionmodificacionfw			lxOrdenprodZadsfw =  .Zadsfw			lxOrdenprodValtafw =  .Versionaltafw			lxOrdenprodUmodifw =  .Usuariomodificacionfw			lxOrdenprodSmodifw =  .Seriemodificacionfw			lxOrdenprodUaltafw =  .Usuarioaltafw			lxOrdenprodSaltafw =  .Seriealtafw			lxOrdenprodBdmodifw =  .Basededatosmodificacionfw			lxOrdenprodEsttrans =  .Estadotransferencia			lxOrdenprodBdaltafw =  .Basededatosaltafw			lxOrdenprodCodigo =  .Codigo			lxOrdenprodObs =  .Obs			lxOrdenprodNumero =  .Numero			lxOrdenprodDescrip =  .Descripcion			lxOrdenprodModelo =  upper( .Modelo_PK ) 			lxOrdenprodFfch =  .Fecha			lxOrdenprodCurvaprod =  upper( .CurvaDeProduccion_PK ) 			lxOrdenprodNcantidad =  .Cantidad			lxOrdenprodProducto =  upper( .ProductoFinal_PK ) 
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  ORDENPROD.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.ORDENPROD set "Fectrans" = <<"'" + this.ConvertirDateSql( lxOrdenprodFectrans ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxOrdenprodFecexpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxOrdenprodFmodifw ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxOrdenprodFaltafw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxOrdenprodFecimpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxOrdenprodHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxOrdenprodHoraexpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxOrdenprodHmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxOrdenprodHoraimpo ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxOrdenprodVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxOrdenprodZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxOrdenprodValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxOrdenprodUmodifw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxOrdenprodSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxOrdenprodUaltafw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxOrdenprodSaltafw ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxOrdenprodBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxOrdenprodEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxOrdenprodBdaltafw ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxOrdenprodCodigo ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxOrdenprodObs ) + "'">>, "Numero" = <<lxOrdenprodNumero>>, "Descrip" = <<"'" + this.FormatearTextoSql( lxOrdenprodDescrip ) + "'">>, "Modelo" = <<"'" + this.FormatearTextoSql( lxOrdenprodModelo ) + "'">>, "Ffch" = <<"'" + this.ConvertirDateSql( lxOrdenprodFfch ) + "'">>, "Curvaprod" = <<"'" + this.FormatearTextoSql( lxOrdenprodCurvaprod ) + "'">>, "Ncantidad" = <<lxOrdenprodNcantidad>>, "Producto" = <<"'" + this.FormatearTextoSql( lxOrdenprodProducto ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'ORDENPROD' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.ORDPCURV where "CodOrden" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ORDPINS where "CodOrden" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ORDPSAL where "CodOrden" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ORDPPROC where "CodOrden" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenCurva
				if this.oEntidad.OrdenCurva.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProducto_PK = loItem.Producto_PK
					lxProductodetalle = loItem.Productodetalle
					lxColor_PK = loItem.Color_PK
					lxColordetalle = loItem.Colordetalle
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxCantidad = loItem.Cantidad
					lxTotal = loItem.Total
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ORDPCURV("NROITEM","CodOrden","Producto","cProdDet","CodColor","CColTxt","CodTalle","CTalleTxt","CantCurva","CantTotal" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxProducto_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProductodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>>, <<lxTotal>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenInsumos
				if this.oEntidad.OrdenInsumos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxColorm_PK = loItem.Colorm_PK
					lxColormdetalle = loItem.Colormdetalle
					lxTallem_PK = loItem.Tallem_PK
					lxTallemdetalle = loItem.Tallemdetalle
					lxInsumo_PK = loItem.Insumo_PK
					lxInsumodetalle = loItem.Insumodetalle
					lxColor_PK = loItem.Color_PK
					lxColororddet = loItem.Colororddet
					lxTalle_PK = loItem.Talle_PK
					lxTalledetalle = loItem.Talledetalle
					lxUnidaddemedida_PK = loItem.Unidaddemedida_PK
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ORDPINS("NROITEM","CodOrden","Proceso","cColor","cColDet","cTalle","cTalleDet","Insumo","cInsDet","ICodColor","IColTxt","ICodTalle","ITalleTxt","UniMed","CantNec" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColororddet ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxUnidaddemedida_PK ) + "'">>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenSalidas
				if this.oEntidad.OrdenSalidas.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
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
						Insert into ZooLogic.ORDPSAL("NROITEM","CodOrden","Proceso","cColor","cColDet","cTalle","cTalleDet","SemiElab","SemiDeta","iColor","IColDet","iTalle","ITalleDEt","Cantidad" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaborado_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxSemielaboradodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.OrdenProcesos
				if this.oEntidad.OrdenProcesos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxOrden = loItem.Orden
					lxTaller_PK = loItem.Taller_PK
					lxInventarioentrada_PK = loItem.Inventarioentrada_PK
					lxInventariosalida_PK = loItem.Inventariosalida_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.ORDPPROC("NROITEM","CodOrden","Codigo","cProcDet","Orden","Taller","InvEnt","InvSal" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<lxOrden>>, <<"'" + this.FormatearTextoSql( lxTaller_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventarioentrada_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventariosalida_PK ) + "'">> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  ORDENPROD.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.ORDENPROD where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.ORDPCURV where "CodOrden" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ORDPINS where "CodOrden" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ORDPSAL where "CodOrden" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.ORDPPROC where "CodOrden" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'ORDENPROD' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.ORDENPROD where  ORDENPROD.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.ORDENPROD where Codigo = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  ORDENPROD.CODIGO != ''" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxORDENPRODNumero as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ORDENDEPRODUCCION'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.ORDENPROD Where  Numero = ] + transform( &lcCursor..Numero     ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..Codigo
				if lxValorClavePK == curSeek.Codigo or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.Codigo and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.Codigo
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.ORDENPROD set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, Numero = ] + transform( &lcCursor..Numero )+ [, Descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"+ [, Modelo = ] + "'" + this.FormatearTextoSql( &lcCursor..Modelo ) + "'"+ [, FFCH = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'"+ [, CurvaProd = ] + "'" + this.FormatearTextoSql( &lcCursor..CurvaProd ) + "'"+ [, nCantidad = ] + transform( &lcCursor..nCantidad )+ [, Producto = ] + "'" + this.FormatearTextoSql( &lcCursor..Producto ) + "'" + [ Where Codigo = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.ORDENPROD Where Codigo = ] + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECTRANS, FECEXPO, FMODIFW, FALTAFW, FECIMPO, HALTAFW, HORAEXPO, HMODIFW, HORAIMPO, VMODIFW, ZADSFW, VALTAFW, UMODIFW, SMODIFW, UALTAFW, SALTAFW, BDMODIFW, ESTTRANS, BDALTAFW, Codigo, Obs, Numero, Descrip, Modelo, FFCH, CurvaProd, nCantidad, Producto
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Codigo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + transform( &lcCursor..Numero ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Modelo ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CurvaProd ) + "'" + ',' + transform( &lcCursor..nCantidad ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..Producto ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.ORDENPROD ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'ORDENDEPRODUCCION'
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
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ORDPCURV Where CodOrden] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ORDPINS Where CodOrden] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ORDPSAL Where CodOrden] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.ORDPPROC Where CodOrden] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMORDENCURVA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CodOrden in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","CodOrden","Producto","cProdDet","CodColor","CColTxt","CodTalle","CTalleTxt","CantCurva","CantTotal"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ORDPCURV ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodOrden   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Producto   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cProdDet   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodColor   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CColTxt    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodTalle   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CTalleTxt  ) + "'" + ',' + transform( cDetallesExistentes.CantCurva  ) + ',' + transform( cDetallesExistentes.CantTotal  ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMORDENINSUMO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CodOrden in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","CodOrden","Proceso","cColor","cColDet","cTalle","cTalleDet","Insumo","cInsDet","ICodColor","IColTxt","ICodTalle","ITalleTxt","UniMed","CantNec"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ORDPINS ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodOrden   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Proceso    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cColor     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cColDet    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cTalle     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cTalleDet  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Insumo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cInsDet    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ICodColor  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IColTxt    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ICodTalle  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ITalleTxt  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.UniMed     ) + "'" + ',' + transform( cDetallesExistentes.CantNec    ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMORDENSALIDA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CodOrden in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","CodOrden","Proceso","cColor","cColDet","cTalle","cTalleDet","SemiElab","SemiDeta","iColor","IColDet","iTalle","ITalleDEt","Cantidad"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ORDPSAL ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodOrden   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Proceso    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cColor     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cColDet    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cTalle     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cTalleDet  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.SemiElab   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.SemiDeta   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.iColor     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IColDet    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.iTalle     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ITalleDEt  ) + "'" + ',' + transform( cDetallesExistentes.Cantidad   ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMORDENPROCESO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CodOrden in ( select Codigo from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","CodOrden","Codigo","cProcDet","Orden","Taller","InvEnt","InvSal"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.ORDPPROC ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodOrden   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cProcDet   ) + "'" + ',' + transform( cDetallesExistentes.Orden      ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Taller     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.InvEnt     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.InvSal     ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( Codigo C (38) , Orden N(16), texto C(80))
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
			Case  lcAlias == lcPrefijo + 'ORDENDEPRODUCCION'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ORDENDEPRODUCCION_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ORDENDEPRODUCCION_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMORDENCURVA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMORDENINSUMO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMORDENSALIDA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMORDENPROCESO'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_ORDENPROD')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'ORDENDEPRODUCCION'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..Codigo
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..Numero )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad ORDENDEPRODUCCION. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ORDENDEPRODUCCION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,Codigo as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( Codigo, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		select max( _Rec ) as Maximo,str( Numero, 12, 0) as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( str( Numero, 12, 0), 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ORDENDEPRODUCCION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FFCH      
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ORDENPROD') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ORDENPROD
Create Table ZooLogic.TablaTrabajo_ORDENPROD ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fectrans" datetime  null, 
"fecexpo" datetime  null, 
"fmodifw" datetime  null, 
"faltafw" datetime  null, 
"fecimpo" datetime  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"hmodifw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"saltafw" char( 7 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"codigo" char( 38 )  null, 
"obs" varchar(max)  null, 
"numero" numeric( 12, 0 )  null, 
"descrip" char( 100 )  null, 
"modelo" char( 15 )  null, 
"ffch" datetime  null, 
"curvaprod" char( 15 )  null, 
"ncantidad" numeric( 5, 0 )  null, 
"producto" char( 15 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_ORDENPROD' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_ORDENPROD' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'ORDENDEPRODUCCION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('modelo','modelo')
			.AgregarMapeo('ffch','ffch')
			.AgregarMapeo('curvaprod','curvaprod')
			.AgregarMapeo('ncantidad','ncantidad')
			.AgregarMapeo('producto','producto')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_ORDENPROD'
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
				Update t Set t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.OBS = isnull( d.OBS, t.OBS ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.MODELO = isnull( d.MODELO, t.MODELO ),t.FFCH = isnull( d.FFCH, t.FFCH ),t.CURVAPROD = isnull( d.CURVAPROD, t.CURVAPROD ),t.NCANTIDAD = isnull( d.NCANTIDAD, t.NCANTIDAD ),t.PRODUCTO = isnull( d.PRODUCTO, t.PRODUCTO )
					from ZooLogic.ORDENPROD t inner join deleted d 
							 on t.Codigo = d.Codigo
							 and  t.Numero = d.Numero
				-- Fin Updates
				insert into ZooLogic.ORDENPROD(Fectrans,Fecexpo,Fmodifw,Faltafw,Fecimpo,Haltafw,Horaexpo,Hmodifw,Horaimpo,Vmodifw,Zadsfw,Valtafw,Umodifw,Smodifw,Ualtafw,Saltafw,Bdmodifw,Esttrans,Bdaltafw,Codigo,Obs,Numero,Descrip,Modelo,Ffch,Curvaprod,Ncantidad,Producto)
					Select isnull( d.FECTRANS,''),isnull( d.FECEXPO,''),isnull( d.FMODIFW,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECIMPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.HMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.SALTAFW,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.CODIGO,''),isnull( d.OBS,''),isnull( d.NUMERO,0),isnull( d.DESCRIP,''),isnull( d.MODELO,''),isnull( d.FFCH,''),isnull( d.CURVAPROD,''),isnull( d.NCANTIDAD,0),isnull( d.PRODUCTO,'')
						From deleted d left join ZooLogic.ORDENPROD pk 
							 on d.Codigo = pk.Codigo
						 left join ZooLogic.ORDENPROD cc 
							 on  d.Numero = cc.Numero
						Where pk.Codigo Is Null 
							 and cc.Numero Is Null 
				-- Fin Inserts
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.Numero as Varchar(12) ) + '','La clave principal no es la esperada'
					from ZooLogic.ORDENPROD t inner join deleted d 
							on   t.Numero = d.Numero
						left join deleted h 
							 on t.Codigo = h.Codigo
							 where h.Codigo is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.Numero as Varchar(12) ) + '','La clave principal a importar ya existe'
					from ZooLogic.ORDENPROD t inner join deleted d 
							 on t.Codigo = d.Codigo
						left join deleted h 
							on   t.Numero = h.Numero
							where   h.Numero is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ORDPCURV( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_ORDENPROD_ORDPCURV
ON ZooLogic.TablaTrabajo_ORDENPROD_ORDPCURV
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODORDEN = isnull( d.CODORDEN, t.CODORDEN ),
t.PRODUCTO = isnull( d.PRODUCTO, t.PRODUCTO ),
t.CPRODDET = isnull( d.CPRODDET, t.CPRODDET ),
t.CODCOLOR = isnull( d.CODCOLOR, t.CODCOLOR ),
t.CCOLTXT = isnull( d.CCOLTXT, t.CCOLTXT ),
t.CODTALLE = isnull( d.CODTALLE, t.CODTALLE ),
t.CTALLETXT = isnull( d.CTALLETXT, t.CTALLETXT ),
t.CANTCURVA = isnull( d.CANTCURVA, t.CANTCURVA ),
t.CANTTOTAL = isnull( d.CANTTOTAL, t.CANTTOTAL )
from ZooLogic.ORDPCURV t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ORDPCURV
( 
"NROITEM",
"CODORDEN",
"PRODUCTO",
"CPRODDET",
"CODCOLOR",
"CCOLTXT",
"CODTALLE",
"CTALLETXT",
"CANTCURVA",
"CANTTOTAL"
 )
Select 
d.NROITEM,
d.CODORDEN,
d.PRODUCTO,
d.CPRODDET,
d.CODCOLOR,
d.CCOLTXT,
d.CODTALLE,
d.CTALLETXT,
d.CANTCURVA,
d.CANTTOTAL
From deleted d left join ZooLogic.ORDPCURV pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ORDPINS( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_ORDENPROD_ORDPINS
ON ZooLogic.TablaTrabajo_ORDENPROD_ORDPINS
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODORDEN = isnull( d.CODORDEN, t.CODORDEN ),
t.PROCESO = isnull( d.PROCESO, t.PROCESO ),
t.CCOLOR = isnull( d.CCOLOR, t.CCOLOR ),
t.CCOLDET = isnull( d.CCOLDET, t.CCOLDET ),
t.CTALLE = isnull( d.CTALLE, t.CTALLE ),
t.CTALLEDET = isnull( d.CTALLEDET, t.CTALLEDET ),
t.INSUMO = isnull( d.INSUMO, t.INSUMO ),
t.CINSDET = isnull( d.CINSDET, t.CINSDET ),
t.ICODCOLOR = isnull( d.ICODCOLOR, t.ICODCOLOR ),
t.ICOLTXT = isnull( d.ICOLTXT, t.ICOLTXT ),
t.ICODTALLE = isnull( d.ICODTALLE, t.ICODTALLE ),
t.ITALLETXT = isnull( d.ITALLETXT, t.ITALLETXT ),
t.UNIMED = isnull( d.UNIMED, t.UNIMED ),
t.CANTNEC = isnull( d.CANTNEC, t.CANTNEC )
from ZooLogic.ORDPINS t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ORDPINS
( 
"NROITEM",
"CODORDEN",
"PROCESO",
"CCOLOR",
"CCOLDET",
"CTALLE",
"CTALLEDET",
"INSUMO",
"CINSDET",
"ICODCOLOR",
"ICOLTXT",
"ICODTALLE",
"ITALLETXT",
"UNIMED",
"CANTNEC"
 )
Select 
d.NROITEM,
d.CODORDEN,
d.PROCESO,
d.CCOLOR,
d.CCOLDET,
d.CTALLE,
d.CTALLEDET,
d.INSUMO,
d.CINSDET,
d.ICODCOLOR,
d.ICOLTXT,
d.ICODTALLE,
d.ITALLETXT,
d.UNIMED,
d.CANTNEC
From deleted d left join ZooLogic.ORDPINS pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ORDPSAL( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_ORDENPROD_ORDPSAL
ON ZooLogic.TablaTrabajo_ORDENPROD_ORDPSAL
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODORDEN = isnull( d.CODORDEN, t.CODORDEN ),
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
from ZooLogic.ORDPSAL t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ORDPSAL
( 
"NROITEM",
"CODORDEN",
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
d.CODORDEN,
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
From deleted d left join ZooLogic.ORDPSAL pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_ORDPPROC( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_ORDENPROD_ORDPPROC
ON ZooLogic.TablaTrabajo_ORDENPROD_ORDPPROC
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODORDEN = isnull( d.CODORDEN, t.CODORDEN ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.CPROCDET = isnull( d.CPROCDET, t.CPROCDET ),
t.ORDEN = isnull( d.ORDEN, t.ORDEN ),
t.TALLER = isnull( d.TALLER, t.TALLER ),
t.INVENT = isnull( d.INVENT, t.INVENT ),
t.INVSAL = isnull( d.INVSAL, t.INVSAL )
from ZooLogic.ORDPPROC t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.ORDPPROC
( 
"NROITEM",
"CODORDEN",
"CODIGO",
"CPROCDET",
"ORDEN",
"TALLER",
"INVENT",
"INVSAL"
 )
Select 
d.NROITEM,
d.CODORDEN,
d.CODIGO,
d.CPROCDET,
d.ORDEN,
d.TALLER,
d.INVENT,
d.INVSAL
From deleted d left join ZooLogic.ORDPPROC pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_ORDENPROD') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_ORDENPROD
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_ORDENDEPRODUCCION' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_ORDENDEPRODUCCION.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ORDENDEPRODUCCION.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ORDENDEPRODUCCION.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_ORDENDEPRODUCCION.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_ORDENDEPRODUCCION.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Horaaltafw = nvl( c_ORDENDEPRODUCCION.Horaaltafw, [] )
					.Horaexpo = nvl( c_ORDENDEPRODUCCION.Horaexpo, [] )
					.Horamodificacionfw = nvl( c_ORDENDEPRODUCCION.Horamodificacionfw, [] )
					.Horaimpo = nvl( c_ORDENDEPRODUCCION.Horaimpo, [] )
					.Versionmodificacionfw = nvl( c_ORDENDEPRODUCCION.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_ORDENDEPRODUCCION.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_ORDENDEPRODUCCION.Usuariomodificacionfw, [] )
					.Seriemodificacionfw = nvl( c_ORDENDEPRODUCCION.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_ORDENDEPRODUCCION.Usuarioaltafw, [] )
					.Seriealtafw = nvl( c_ORDENDEPRODUCCION.Seriealtafw, [] )
					.Basededatosmodificacionfw = nvl( c_ORDENDEPRODUCCION.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_ORDENDEPRODUCCION.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_ORDENDEPRODUCCION.Basededatosaltafw, [] )
					.Codigo = nvl( c_ORDENDEPRODUCCION.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Numero = nvl( c_ORDENDEPRODUCCION.Numero, 0 )
					.Ordencurva.Limpiar()
					.Ordencurva.SetearEsNavegacion( .lProcesando )
					.Ordencurva.Cargar()
					.Ordeninsumos.Limpiar()
					.Ordeninsumos.SetearEsNavegacion( .lProcesando )
					.Ordeninsumos.Cargar()
					.Ordensalidas.Limpiar()
					.Ordensalidas.SetearEsNavegacion( .lProcesando )
					.Ordensalidas.Cargar()
					.Descripcion = nvl( c_ORDENDEPRODUCCION.Descripcion, [] )
					.Modelo_PK =  nvl( c_ORDENDEPRODUCCION.Modelo, [] )
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_ORDENDEPRODUCCION.Fecha, ctod( '  /  /    ' ) ) )
					.Curvadeproduccion_PK =  nvl( c_ORDENDEPRODUCCION.Curvadeproduccion, [] )
					.Cantidad = nvl( c_ORDENDEPRODUCCION.Cantidad, 0 )
					.Ordenprocesos.Limpiar()
					.Ordenprocesos.SetearEsNavegacion( .lProcesando )
					.Ordenprocesos.Cargar()
					.Productofinal_PK =  nvl( c_ORDENDEPRODUCCION.Productofinal, [] )
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
	function ObtenerIdPorClaveCandidata() as variant
		local lxRetorno as Variant
		lxRetorno = ''
		if this.ConsultarPorClaveCandidata()
			lxRetorno = c_ORDENDEPRODUCCION.CODIGO
		endif
		return lxRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ActualizarLosNROItemDeLosDetalles() as void
		local loDetalle as object, loItem as object, lnContadorNroItem as integer, lnIndex as integer
		
		loDetalle = this.oEntidad.OrdenCurva
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

		loDetalle = this.oEntidad.OrdenInsumos
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

		loDetalle = this.oEntidad.OrdenSalidas
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

		loDetalle = this.oEntidad.OrdenProcesos
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
		return c_ORDENDEPRODUCCION.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.ORDENPROD' )
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
								from ZooLogic.ORDENPROD 
								Where   ORDENPROD.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "ORDENPROD", "", lcCursor, set("Datasession") )
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
			"Fectrans" as "Fechatransferencia", "Fecexpo" as "Fechaexpo", "Fmodifw" as "Fechamodificacionfw", "Faltafw" as "Fechaaltafw", "Fecimpo" as "Fechaimpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Saltafw" as "Seriealtafw", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Codigo" as "Codigo", "Obs" as "Obs", "Numero" as "Numero", "Descrip" as "Descripcion", "Modelo" as "Modelo", "Ffch" as "Fecha", "Curvaprod" as "Curvadeproduccion", "Ncantidad" as "Cantidad", "Producto" as "Productofinal"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.ORDENPROD 
								Where   ORDENPROD.CODIGO != ''
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
	Tabla = 'ORDENPROD'
	Filtro = " ORDENPROD.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " ORDENPROD.CODIGO != ''"
	AnchoCampo = 13
	Caracteres = 13
	nrodecolumnas = 0
	signopregunta = .T.
	signopregunta2 = .t.
	TablaAuxiliar = .f.
	cOrden = "ORDENPROD.Numero"
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
	<row entidad="ORDENDEPRODUCCION                       " atributo="FECHATRANSFERENCIA                      " tabla="ORDENPROD      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="FECHAEXPO                               " tabla="ORDENPROD      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="FECHAMODIFICACIONFW                     " tabla="ORDENPROD      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="FECHAALTAFW                             " tabla="ORDENPROD      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                      " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="FECHAIMPO                               " tabla="ORDENPROD      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="HORAALTAFW                              " tabla="ORDENPROD      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="HORAEXPO                                " tabla="ORDENPROD      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="HORAMODIFICACIONFW                      " tabla="ORDENPROD      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="HORAIMPO                                " tabla="ORDENPROD      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="VERSIONMODIFICACIONFW                   " tabla="ORDENPROD      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="ZADSFW                                  " tabla="ORDENPROD      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="VERSIONALTAFW                           " tabla="ORDENPROD      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="USUARIOMODIFICACIONFW                   " tabla="ORDENPROD      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="SERIEMODIFICACIONFW                     " tabla="ORDENPROD      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="USUARIOALTAFW                           " tabla="ORDENPROD      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="SERIEALTAFW                             " tabla="ORDENPROD      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="ORDENPROD      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="ESTADOTRANSFERENCIA                     " tabla="ORDENPROD      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="BASEDEDATOSALTAFW                       " tabla="ORDENPROD      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="CODIGO                                  " tabla="ORDENPROD      " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="0" etiqueta="Código                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="OBS                                     " tabla="ORDENPROD      " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="NUMERO                                  " tabla="ORDENPROD      " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Número                                                                                                                                                          " dominio="CLAVECANDIDATA                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="ORDENCURVA                              " tabla="ORDPCURV       " campo="CODORDEN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Producción                                                                                                                                                      " dominio="DETALLEITEMORDENCURVA         " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="ORDENINSUMOS                            " tabla="ORDPINS        " campo="CODORDEN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Insumos                                                                                                                                                         " dominio="DETALLEITEMORDENINSUMO        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="3" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="ORDENSALIDAS                            " tabla="ORDPSAL        " campo="CODORDEN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Salidas                                                                                                                                                         " dominio="DETALLEITEMORDENSALIDA        " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="4" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="DESCRIPCION                             " tabla="ORDENPROD      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="MODELO                                  " tabla="ORDENPROD      " campo="MODELO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MODELODEPRODUCCION                      " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="6" etiqueta="Modelo                                                                                                                                                          " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="FECHA                                   " tabla="ORDENPROD      " campo="FFCH      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="true" admitebusqueda="10" etiqueta="Fecha                                                                                                                                                           " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="BLANCO1                                 " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Blanco 1                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="CURVADEPRODUCCION                       " tabla="ORDENPROD      " campo="CURVAPROD " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CURVADEPRODUCCION                       " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Curva de producción                                                                                                                                             " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="CANTIDAD                                " tabla="ORDENPROD      " campo="NCANTIDAD " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="5" decimales="0" valorsugerido="=1                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="410" etiqueta="Cantidad                                                                                                                                                        " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="BLANCO2                                 " tabla="               " campo="          " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="1" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Blanco 2                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="9" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="ORDENPROCESOS                           " tabla="ORDPPROC       " campo="CODORDEN  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Procesos                                                                                                                                                        " dominio="DETALLEITEMORDENPROCESO       " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="9" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="PRODUCTOFINAL                           " tabla="ORDENPROD      " campo="PRODUCTO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Producto final                                                                                                                                                  " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MODELODEPRODUCCION                      " atributo="DESCRIPCION                             " tabla="MODELOPROD     " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="7" etiqueta="Detalle Mod.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MODELOPROD On ORDENPROD.MODELO = MODELOPROD.Codigo And  MODELOPROD.CODIGO != ''                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CURVADEPRODUCCION                       " atributo="DESCRIPCION                             " tabla="CURVAPROD      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Cur.                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CURVAPROD On ORDENPROD.CURVAPROD = CURVAPROD.Codigo And  CURVAPROD.CODIGO != ''                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="9" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ART On ORDENPROD.PRODUCTO = ART.ARTCOD And  ART.ARTCOD != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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