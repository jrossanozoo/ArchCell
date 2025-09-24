
define class Din_EntidadGESTIONDEPRODUCCIONAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_GESTIONDEPRODUCCION'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = [str( Numero, 12, 0)]
	cExpresionCCPorCampos = [str( #tabla#.Numero, 12, 0)]
	cTagClaveCandidata = '_GOPCC'
	cTagClavePk = '_GOPPK'
	cTablaPrincipal = 'GESTIONPROD'
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
			local  lxGestionprodFectrans, lxGestionprodFaltafw, lxGestionprodFmodifw, lxGestionprodFecimpo, lxGestionprodFecexpo, lxGestionprodHaltafw, lxGestionprodHoraexpo, lxGestionprodHmodifw, lxGestionprodVmodifw, lxGestionprodZadsfw, lxGestionprodValtafw, lxGestionprodUaltafw, lxGestionprodUmodifw, lxGestionprodSaltafw, lxGestionprodSmodifw, lxGestionprodHoraimpo, lxGestionprodBdmodifw, lxGestionprodEsttrans, lxGestionprodBdaltafw, lxGestionprodModelo, lxGestionprodCodigo, lxGestionprodObs, lxGestionprodNumero, lxGestionprodFfch, lxGestionprodOrdendepro, lxGestionprodProceso, lxGestionprodTaller, lxGestionprodInventorig, lxGestionprodInventdest
				lxGestionprodFectrans =  .Fechatransferencia			lxGestionprodFaltafw =  .Fechaaltafw			lxGestionprodFmodifw =  .Fechamodificacionfw			lxGestionprodFecimpo =  .Fechaimpo			lxGestionprodFecexpo =  .Fechaexpo			lxGestionprodHaltafw =  .Horaaltafw			lxGestionprodHoraexpo =  .Horaexpo			lxGestionprodHmodifw =  .Horamodificacionfw			lxGestionprodVmodifw =  .Versionmodificacionfw			lxGestionprodZadsfw =  .Zadsfw			lxGestionprodValtafw =  .Versionaltafw			lxGestionprodUaltafw =  .Usuarioaltafw			lxGestionprodUmodifw =  .Usuariomodificacionfw			lxGestionprodSaltafw =  .Seriealtafw			lxGestionprodSmodifw =  .Seriemodificacionfw			lxGestionprodHoraimpo =  .Horaimpo			lxGestionprodBdmodifw =  .Basededatosmodificacionfw			lxGestionprodEsttrans =  .Estadotransferencia			lxGestionprodBdaltafw =  .Basededatosaltafw			lxGestionprodModelo =  upper( .Modelo_PK ) 			lxGestionprodCodigo =  .Codigo			lxGestionprodObs =  .Obs			lxGestionprodNumero =  .Numero			lxGestionprodFfch =  .Fecha			lxGestionprodOrdendepro =  upper( .OrdenDeProduccion_PK ) 			lxGestionprodProceso =  upper( .Proceso_PK ) 			lxGestionprodTaller =  upper( .Taller_PK ) 			lxGestionprodInventorig =  upper( .InventarioOrigen_PK ) 			lxGestionprodInventdest =  upper( .InventarioDestino_PK ) 
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxGestionprodCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.GESTIONPROD ( "Fectrans","Faltafw","Fmodifw","Fecimpo","Fecexpo","Haltafw","Horaexpo","Hmodifw","Vmodifw","Zadsfw","Valtafw","Ualtafw","Umodifw","Saltafw","Smodifw","Horaimpo","Bdmodifw","Esttrans","Bdaltafw","Modelo","Codigo","Obs","Numero","Ffch","Ordendepro","Proceso","Taller","Inventorig","Inventdest" ) values ( <<"'" + this.ConvertirDateSql( lxGestionprodFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxGestionprodFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxGestionprodFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxGestionprodFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxGestionprodFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodModelo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodObs ) + "'" >>, <<lxGestionprodNumero >>, <<"'" + this.ConvertirDateSql( lxGestionprodFfch ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodOrdendepro ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodProceso ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodTaller ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodInventorig ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodInventdest ) + "'" >> )
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
			for each loItem in this.oEntidad.Procesos
				if this.oEntidad.Procesos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxOrden = loItem.Orden
					lxTaller_PK = loItem.Taller_PK
					lxInventarioentrada_PK = loItem.Inventarioentrada_PK
					lxInventariosalida_PK = loItem.Inventariosalida_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.GESTORDPRO("NROITEM","CodGestPro","Codigo","cProcDet","Orden","Taller","InvEnt","InvSal" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<lxOrden>>, <<"'" + this.FormatearTextoSql( lxTaller_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventarioentrada_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventariosalida_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.GestionCurva
				if this.oEntidad.GestionCurva.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxNroitem = lnContadorNroItem
					lxComportamiento = loItem.Comportamiento
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
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
					lxPartida = loItem.Partida
					lxCantproducida = loItem.Cantproducida
					lxCantdescarte = loItem.Cantdescarte
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.GESPCURV("IdItem","NROITEM","COMP","GesProdCur","MARTDF","DESCRIPDF","cColor","cColDet","cTalle","cTalleDet","Insumo","InsumoDet","CodColor","FCOLTXT","CodTalle","TalleDet","Partida","CantProd","CantDesc" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxNroitem>>, <<lxComportamiento>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxPartida ) + "'">>, <<lxCantproducida>>, <<lxCantdescarte>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.GestionDescartes
				if this.oEntidad.GestionDescartes.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
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
					lxPartida = loItem.Partida
					lxMotdescarte_PK = loItem.Motdescarte_PK
					lxMotdescartedetalle = loItem.Motdescartedetalle
					lxInventariodest_PK = loItem.Inventariodest_PK
					lxInventariodestdetalle = loItem.Inventariodestdetalle
					lxCantdescarte = loItem.Cantdescarte
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.GESPDESC("IdItem","COMP","NROITEM","GesProdDes","MARTDF","DESCRIPDF","cColor","cColDet","cTalle","cTalleDet","Insumo","InsumoDet","CodColor","FCOLTXT","CodTalle","ITalleTxt","Partida","MotDesc","MotDescDet","InventDest","InventDDet","CantDesc" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxPartida ) + "'">>, <<"'" + this.FormatearTextoSql( lxMotdescarte_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxMotdescartedetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventariodest_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventariodestdetalle ) + "'">>, <<lxCantdescarte>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.GestionInsumos
				if this.oEntidad.GestionInsumos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxCantporunidad = loItem.Cantporunidad
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
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
					lxPartida = loItem.Partida
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.GESPINS("CantUnit","IdItem","COMP","NROITEM","GesProdIns","MARTDF","DESCRIPDF","cColor","cColDet","cTalle","cTalleDet","Insumo","cInsDet","CodColor","FCOLTXT","CodTalle","ITalleTxt","Partida","Cantidad" ) values ( <<lxCantporunidad>>, <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxPartida ) + "'">>, <<lxCantidad>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.GestionInsumosDescartes
				if this.oEntidad.GestionInsumosDescartes.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
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
					lxPartida = loItem.Partida
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.GESPIND("IdItem","COMP","NROITEM","GesProdInD","MARTDF","DESCRIPDF","cColor","cColDet","cTalle","cTalleDet","Insumo","cInsDet","CodColor","FCOLTXT","CodTalle","ITalleTxt","Partida","Cantidad" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxPartida ) + "'">>, <<lxCantidad>> ) 
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
			this.GenerarSentenciasComponentes()
			local  lxGestionprodFectrans, lxGestionprodFaltafw, lxGestionprodFmodifw, lxGestionprodFecimpo, lxGestionprodFecexpo, lxGestionprodHaltafw, lxGestionprodHoraexpo, lxGestionprodHmodifw, lxGestionprodVmodifw, lxGestionprodZadsfw, lxGestionprodValtafw, lxGestionprodUaltafw, lxGestionprodUmodifw, lxGestionprodSaltafw, lxGestionprodSmodifw, lxGestionprodHoraimpo, lxGestionprodBdmodifw, lxGestionprodEsttrans, lxGestionprodBdaltafw, lxGestionprodModelo, lxGestionprodCodigo, lxGestionprodObs, lxGestionprodNumero, lxGestionprodFfch, lxGestionprodOrdendepro, lxGestionprodProceso, lxGestionprodTaller, lxGestionprodInventorig, lxGestionprodInventdest
				lxGestionprodFectrans =  .Fechatransferencia			lxGestionprodFaltafw =  .Fechaaltafw			lxGestionprodFmodifw =  .Fechamodificacionfw			lxGestionprodFecimpo =  .Fechaimpo			lxGestionprodFecexpo =  .Fechaexpo			lxGestionprodHaltafw =  .Horaaltafw			lxGestionprodHoraexpo =  .Horaexpo			lxGestionprodHmodifw =  .Horamodificacionfw			lxGestionprodVmodifw =  .Versionmodificacionfw			lxGestionprodZadsfw =  .Zadsfw			lxGestionprodValtafw =  .Versionaltafw			lxGestionprodUaltafw =  .Usuarioaltafw			lxGestionprodUmodifw =  .Usuariomodificacionfw			lxGestionprodSaltafw =  .Seriealtafw			lxGestionprodSmodifw =  .Seriemodificacionfw			lxGestionprodHoraimpo =  .Horaimpo			lxGestionprodBdmodifw =  .Basededatosmodificacionfw			lxGestionprodEsttrans =  .Estadotransferencia			lxGestionprodBdaltafw =  .Basededatosaltafw			lxGestionprodModelo =  upper( .Modelo_PK ) 			lxGestionprodCodigo =  .Codigo			lxGestionprodObs =  .Obs			lxGestionprodNumero =  .Numero			lxGestionprodFfch =  .Fecha			lxGestionprodOrdendepro =  upper( .OrdenDeProduccion_PK ) 			lxGestionprodProceso =  upper( .Proceso_PK ) 			lxGestionprodTaller =  upper( .Taller_PK ) 			lxGestionprodInventorig =  upper( .InventarioOrigen_PK ) 			lxGestionprodInventdest =  upper( .InventarioDestino_PK ) 
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.GESTIONPROD set "Fectrans" = <<"'" + this.ConvertirDateSql( lxGestionprodFectrans ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxGestionprodFaltafw ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxGestionprodFmodifw ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxGestionprodFecimpo ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxGestionprodFecexpo ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxGestionprodHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxGestionprodHoraexpo ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxGestionprodHmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxGestionprodVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxGestionprodZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxGestionprodValtafw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxGestionprodUaltafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxGestionprodUmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxGestionprodSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxGestionprodSmodifw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxGestionprodHoraimpo ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxGestionprodBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxGestionprodEsttrans ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxGestionprodBdaltafw ) + "'">>,"Modelo" = <<"'" + this.FormatearTextoSql( lxGestionprodModelo ) + "'">>,"Codigo" = <<"'" + this.FormatearTextoSql( lxGestionprodCodigo ) + "'">>,"Obs" = <<"'" + this.FormatearTextoSql( lxGestionprodObs ) + "'">>,"Numero" = <<lxGestionprodNumero>>,"Ffch" = <<"'" + this.ConvertirDateSql( lxGestionprodFfch ) + "'">>,"Ordendepro" = <<"'" + this.FormatearTextoSql( lxGestionprodOrdendepro ) + "'">>,"Proceso" = <<"'" + this.FormatearTextoSql( lxGestionprodProceso ) + "'">>,"Taller" = <<"'" + this.FormatearTextoSql( lxGestionprodTaller ) + "'">>,"Inventorig" = <<"'" + this.FormatearTextoSql( lxGestionprodInventorig ) + "'">>,"Inventdest" = <<"'" + this.FormatearTextoSql( lxGestionprodInventdest ) + "'">> where "Codigo" = <<"'" + this.FormatearTextoSql( lxGestionprodCodigo ) + "'">> and  GESTIONPROD.CODIGO != '' << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
			.EjecutarSentencias( This.ColSentencias )
		this.ComprobarTransaccion()
			this.oConexion.EjecutarSql( 'delete from ZooLogic.GESTORDPRO where "CodGestPro" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.GESPCURV where "GesProdCur" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.GESPDESC where "GesProdDes" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.GESPINS where "GesProdIns" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.GESPIND where "GesProdInD" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Procesos
				if this.oEntidad.Procesos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxOrden = loItem.Orden
					lxTaller_PK = loItem.Taller_PK
					lxInventarioentrada_PK = loItem.Inventarioentrada_PK
					lxInventariosalida_PK = loItem.Inventariosalida_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.GESTORDPRO("NROITEM","CodGestPro","Codigo","cProcDet","Orden","Taller","InvEnt","InvSal" ) values ( <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<lxOrden>>, <<"'" + this.FormatearTextoSql( lxTaller_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventarioentrada_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventariosalida_PK ) + "'">> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.GestionCurva
				if this.oEntidad.GestionCurva.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxNroitem = lnContadorNroItem
					lxComportamiento = loItem.Comportamiento
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
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
					lxPartida = loItem.Partida
					lxCantproducida = loItem.Cantproducida
					lxCantdescarte = loItem.Cantdescarte
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.GESPCURV("IdItem","NROITEM","COMP","GesProdCur","MARTDF","DESCRIPDF","cColor","cColDet","cTalle","cTalleDet","Insumo","InsumoDet","CodColor","FCOLTXT","CodTalle","TalleDet","Partida","CantProd","CantDesc" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxNroitem>>, <<lxComportamiento>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxPartida ) + "'">>, <<lxCantproducida>>, <<lxCantdescarte>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.GestionDescartes
				if this.oEntidad.GestionDescartes.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
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
					lxPartida = loItem.Partida
					lxMotdescarte_PK = loItem.Motdescarte_PK
					lxMotdescartedetalle = loItem.Motdescartedetalle
					lxInventariodest_PK = loItem.Inventariodest_PK
					lxInventariodestdetalle = loItem.Inventariodestdetalle
					lxCantdescarte = loItem.Cantdescarte
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.GESPDESC("IdItem","COMP","NROITEM","GesProdDes","MARTDF","DESCRIPDF","cColor","cColDet","cTalle","cTalleDet","Insumo","InsumoDet","CodColor","FCOLTXT","CodTalle","ITalleTxt","Partida","MotDesc","MotDescDet","InventDest","InventDDet","CantDesc" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxPartida ) + "'">>, <<"'" + this.FormatearTextoSql( lxMotdescarte_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxMotdescartedetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventariodest_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventariodestdetalle ) + "'">>, <<lxCantdescarte>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.GestionInsumos
				if this.oEntidad.GestionInsumos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxCantporunidad = loItem.Cantporunidad
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
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
					lxPartida = loItem.Partida
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.GESPINS("CantUnit","IdItem","COMP","NROITEM","GesProdIns","MARTDF","DESCRIPDF","cColor","cColDet","cTalle","cTalleDet","Insumo","cInsDet","CodColor","FCOLTXT","CodTalle","ITalleTxt","Partida","Cantidad" ) values ( <<lxCantporunidad>>, <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxPartida ) + "'">>, <<lxCantidad>> ) 
					endtext
					this.oConexion.EjecutarSql( strtran( lcCadena, chr(9), '' ) )
					this.ComprobarTransaccion()

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.GestionInsumosDescartes
				if this.oEntidad.GestionInsumosDescartes.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
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
					lxPartida = loItem.Partida
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.GESPIND("IdItem","COMP","NROITEM","GesProdInD","MARTDF","DESCRIPDF","cColor","cColDet","cTalle","cTalleDet","Insumo","cInsDet","CodColor","FCOLTXT","CodTalle","ITalleTxt","Partida","Cantidad" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, <<"'" + this.FormatearTextoSql( lxValorClavePrimaria ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxPartida ) + "'">>, <<lxCantidad>> ) 
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.GESTIONPROD where " + this.ConvertirFuncionesSql( " GESTIONPROD.CODIGO != ''" ) )
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
			Local lxGestionprodCodigo
			lxGestionprodCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Modelo" as "Modelo", "Codigo" as "Codigo", "Obs" as "Obs", "Numero" as "Numero", "Ffch" as "Fecha", "Ordendepro" as "Ordendeproduccion", "Proceso" as "Proceso", "Taller" as "Taller", "Inventorig" as "Inventarioorigen", "Inventdest" as "Inventariodestino" from ZooLogic.GESTIONPROD where "Codigo" = <<"'" + this.FormatearTextoSql( lxGestionprodCodigo ) + "'">> and  GESTIONPROD.CODIGO != ''
			endtext
			use in select('c_GESTIONDEPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GESTIONDEPRODUCCION', set( 'Datasession' ) )

			if reccount( 'c_GESTIONDEPRODUCCION' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codgestpro" as "Codigo", "Codigo" as "Proceso", "Cprocdet" as "Procesodetalle", "Orden" as "Orden", "Taller" as "Taller", "Invent" as "Inventarioentrada", "Invsal" as "Inventariosalida" from ZooLogic.GESTORDPRO where CodGestPro = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Procesos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Procesos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Procesos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Gesprodcur" as "Codigo", "Martdf" as "Articulo", "Descripdf" as "Articulodetalle", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Insumodet" as "Insumodetalle", "Codcolor" as "Color", "Fcoltxt" as "Colordetalle", "Codtalle" as "Talle", "Talledet" as "Talledetalle", "Partida" as "Partida", "Cantprod" as "Cantproducida", "Cantdesc" as "Cantdescarte" from ZooLogic.GESPCURV where GesProdCur = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionCurva')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionCurva', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionCurva
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Gesproddes" as "Codigo", "Martdf" as "Articulo", "Descripdf" as "Articulodetalle", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Insumodet" as "Insumodetalle", "Codcolor" as "Color", "Fcoltxt" as "Colordetalle", "Codtalle" as "Talle", "Italletxt" as "Talledetalle", "Partida" as "Partida", "Motdesc" as "Motdescarte", "Motdescdet" as "Motdescartedetalle", "Inventdest" as "Inventariodest", "Inventddet" as "Inventariodestdetalle", "Cantdesc" as "Cantdescarte" from ZooLogic.GESPDESC where GesProdDes = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionDescartes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionDescartes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionDescartes
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Cantunit" as "Cantporunidad", "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Gesprodins" as "Codigo", "Martdf" as "Articulo", "Descripdf" as "Articulodetalle", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Cinsdet" as "Insumodetalle", "Codcolor" as "Color", "Fcoltxt" as "Colordetalle", "Codtalle" as "Talle", "Italletxt" as "Talledetalle", "Partida" as "Partida", "Cantidad" as "Cantidad" from ZooLogic.GESPINS where GesProdIns = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Gesprodind" as "Codigo", "Martdf" as "Articulo", "Descripdf" as "Articulodetalle", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Cinsdet" as "Insumodetalle", "Codcolor" as "Color", "Fcoltxt" as "Colordetalle", "Codtalle" as "Talle", "Italletxt" as "Talledetalle", "Partida" as "Partida", "Cantidad" as "Cantidad" from ZooLogic.GESPIND where GesProdInD = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionInsumosDescartes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionInsumosDescartes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionInsumosDescartes
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ConsultarPorClaveCandidata() as Boolean
		local llRetorno as Boolean
		llRetorno = .t.
		with this.oEntidad
			Local lxGESTIONPRODNumero As Variant
			lxGESTIONPRODNumero = .Numero
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Modelo" as "Modelo", "Codigo" as "Codigo", "Obs" as "Obs", "Numero" as "Numero", "Ffch" as "Fecha", "Ordendepro" as "Ordendeproduccion", "Proceso" as "Proceso", "Taller" as "Taller", "Inventorig" as "Inventarioorigen", "Inventdest" as "Inventariodestino" from ZooLogic.GESTIONPROD where  GESTIONPROD.CODIGO != '' And Numero = <<lxGESTIONPRODNumero>>
			endtext
			use in select('c_GESTIONDEPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GESTIONDEPRODUCCION', set( 'Datasession' ) )
			if reccount( 'c_GESTIONDEPRODUCCION' ) = 0
				llRetorno = .f.
			else
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codgestpro" as "Codigo", "Codigo" as "Proceso", "Cprocdet" as "Procesodetalle", "Orden" as "Orden", "Taller" as "Taller", "Invent" as "Inventarioentrada", "Invsal" as "Inventariosalida" from ZooLogic.GESTORDPRO where CodGestPro = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Procesos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Procesos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Procesos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Gesprodcur" as "Codigo", "Martdf" as "Articulo", "Descripdf" as "Articulodetalle", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Insumodet" as "Insumodetalle", "Codcolor" as "Color", "Fcoltxt" as "Colordetalle", "Codtalle" as "Talle", "Talledet" as "Talledetalle", "Partida" as "Partida", "Cantprod" as "Cantproducida", "Cantdesc" as "Cantdescarte" from ZooLogic.GESPCURV where GesProdCur = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionCurva')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionCurva', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionCurva
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Gesproddes" as "Codigo", "Martdf" as "Articulo", "Descripdf" as "Articulodetalle", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Insumodet" as "Insumodetalle", "Codcolor" as "Color", "Fcoltxt" as "Colordetalle", "Codtalle" as "Talle", "Italletxt" as "Talledetalle", "Partida" as "Partida", "Motdesc" as "Motdescarte", "Motdescdet" as "Motdescartedetalle", "Inventdest" as "Inventariodest", "Inventddet" as "Inventariodestdetalle", "Cantdesc" as "Cantdescarte" from ZooLogic.GESPDESC where GesProdDes = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionDescartes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionDescartes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionDescartes
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Cantunit" as "Cantporunidad", "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Gesprodins" as "Codigo", "Martdf" as "Articulo", "Descripdf" as "Articulodetalle", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Cinsdet" as "Insumodetalle", "Codcolor" as "Color", "Fcoltxt" as "Colordetalle", "Codtalle" as "Talle", "Italletxt" as "Talledetalle", "Partida" as "Partida", "Cantidad" as "Cantidad" from ZooLogic.GESPINS where GesProdIns = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Gesprodind" as "Codigo", "Martdf" as "Articulo", "Descripdf" as "Articulodetalle", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Cinsdet" as "Insumodetalle", "Codcolor" as "Color", "Fcoltxt" as "Colordetalle", "Codtalle" as "Talle", "Italletxt" as "Talledetalle", "Partida" as "Partida", "Cantidad" as "Cantidad" from ZooLogic.GESPIND where GesProdInD = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionInsumosDescartes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionInsumosDescartes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionInsumosDescartes
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxGestionprodCodigo as Variant
		llRetorno = .t.
		lxGestionprodCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.GESTIONPROD where "Codigo" = <<"'" + this.FormatearTextoSql( lxGestionprodCodigo ) + "'">> and  GESTIONPROD.CODIGO != ''
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
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Modelo" as "Modelo", "Codigo" as "Codigo", "Obs" as "Obs", "Numero" as "Numero", "Ffch" as "Fecha", "Ordendepro" as "Ordendeproduccion", "Proceso" as "Proceso", "Taller" as "Taller", "Inventorig" as "Inventarioorigen", "Inventdest" as "Inventariodestino" from ZooLogic.GESTIONPROD where  GESTIONPROD.CODIGO != '' order by Numero
			endtext
			use in select('c_GESTIONDEPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GESTIONDEPRODUCCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codgestpro" as "Codigo", "Codigo" as "Proceso", "Cprocdet" as "Procesodetalle", "Orden" as "Orden", "Taller" as "Taller", "Invent" as "Inventarioentrada", "Invsal" as "Inventariosalida" from ZooLogic.GESTORDPRO where CodGestPro = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Procesos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Procesos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Procesos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Gesprodcur" as "Codigo", "Martdf" as "Articulo", "Descripdf" as "Articulodetalle", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Insumodet" as "Insumodetalle", "Codcolor" as "Color", "Fcoltxt" as "Colordetalle", "Codtalle" as "Talle", "Talledet" as "Talledetalle", "Partida" as "Partida", "Cantprod" as "Cantproducida", "Cantdesc" as "Cantdescarte" from ZooLogic.GESPCURV where GesProdCur = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionCurva')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionCurva', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionCurva
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Gesproddes" as "Codigo", "Martdf" as "Articulo", "Descripdf" as "Articulodetalle", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Insumodet" as "Insumodetalle", "Codcolor" as "Color", "Fcoltxt" as "Colordetalle", "Codtalle" as "Talle", "Italletxt" as "Talledetalle", "Partida" as "Partida", "Motdesc" as "Motdescarte", "Motdescdet" as "Motdescartedetalle", "Inventdest" as "Inventariodest", "Inventddet" as "Inventariodestdetalle", "Cantdesc" as "Cantdescarte" from ZooLogic.GESPDESC where GesProdDes = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionDescartes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionDescartes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionDescartes
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Cantunit" as "Cantporunidad", "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Gesprodins" as "Codigo", "Martdf" as "Articulo", "Descripdf" as "Articulodetalle", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Cinsdet" as "Insumodetalle", "Codcolor" as "Color", "Fcoltxt" as "Colordetalle", "Codtalle" as "Talle", "Italletxt" as "Talledetalle", "Partida" as "Partida", "Cantidad" as "Cantidad" from ZooLogic.GESPINS where GesProdIns = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Gesprodind" as "Codigo", "Martdf" as "Articulo", "Descripdf" as "Articulodetalle", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Cinsdet" as "Insumodetalle", "Codcolor" as "Color", "Fcoltxt" as "Colordetalle", "Codtalle" as "Talle", "Italletxt" as "Talledetalle", "Partida" as "Partida", "Cantidad" as "Cantidad" from ZooLogic.GESPIND where GesProdInD = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionInsumosDescartes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionInsumosDescartes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionInsumosDescartes
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
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Modelo" as "Modelo", "Codigo" as "Codigo", "Obs" as "Obs", "Numero" as "Numero", "Ffch" as "Fecha", "Ordendepro" as "Ordendeproduccion", "Proceso" as "Proceso", "Taller" as "Taller", "Inventorig" as "Inventarioorigen", "Inventdest" as "Inventariodestino" from ZooLogic.GESTIONPROD where  str( Numero, 12, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  GESTIONPROD.CODIGO != '' order by Numero
			endtext
			use in select('c_GESTIONDEPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GESTIONDEPRODUCCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codgestpro" as "Codigo", "Codigo" as "Proceso", "Cprocdet" as "Procesodetalle", "Orden" as "Orden", "Taller" as "Taller", "Invent" as "Inventarioentrada", "Invsal" as "Inventariosalida" from ZooLogic.GESTORDPRO where CodGestPro = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Procesos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Procesos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Procesos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Gesprodcur" as "Codigo", "Martdf" as "Articulo", "Descripdf" as "Articulodetalle", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Insumodet" as "Insumodetalle", "Codcolor" as "Color", "Fcoltxt" as "Colordetalle", "Codtalle" as "Talle", "Talledet" as "Talledetalle", "Partida" as "Partida", "Cantprod" as "Cantproducida", "Cantdesc" as "Cantdescarte" from ZooLogic.GESPCURV where GesProdCur = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionCurva')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionCurva', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionCurva
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Gesproddes" as "Codigo", "Martdf" as "Articulo", "Descripdf" as "Articulodetalle", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Insumodet" as "Insumodetalle", "Codcolor" as "Color", "Fcoltxt" as "Colordetalle", "Codtalle" as "Talle", "Italletxt" as "Talledetalle", "Partida" as "Partida", "Motdesc" as "Motdescarte", "Motdescdet" as "Motdescartedetalle", "Inventdest" as "Inventariodest", "Inventddet" as "Inventariodestdetalle", "Cantdesc" as "Cantdescarte" from ZooLogic.GESPDESC where GesProdDes = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionDescartes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionDescartes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionDescartes
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Cantunit" as "Cantporunidad", "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Gesprodins" as "Codigo", "Martdf" as "Articulo", "Descripdf" as "Articulodetalle", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Cinsdet" as "Insumodetalle", "Codcolor" as "Color", "Fcoltxt" as "Colordetalle", "Codtalle" as "Talle", "Italletxt" as "Talledetalle", "Partida" as "Partida", "Cantidad" as "Cantidad" from ZooLogic.GESPINS where GesProdIns = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Gesprodind" as "Codigo", "Martdf" as "Articulo", "Descripdf" as "Articulodetalle", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Cinsdet" as "Insumodetalle", "Codcolor" as "Color", "Fcoltxt" as "Colordetalle", "Codtalle" as "Talle", "Italletxt" as "Talledetalle", "Partida" as "Partida", "Cantidad" as "Cantidad" from ZooLogic.GESPIND where GesProdInD = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionInsumosDescartes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionInsumosDescartes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionInsumosDescartes
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
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Modelo" as "Modelo", "Codigo" as "Codigo", "Obs" as "Obs", "Numero" as "Numero", "Ffch" as "Fecha", "Ordendepro" as "Ordendeproduccion", "Proceso" as "Proceso", "Taller" as "Taller", "Inventorig" as "Inventarioorigen", "Inventdest" as "Inventariodestino" from ZooLogic.GESTIONPROD where  str( Numero, 12, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  GESTIONPROD.CODIGO != '' order by Numero desc
			endtext
			use in select('c_GESTIONDEPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GESTIONDEPRODUCCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codgestpro" as "Codigo", "Codigo" as "Proceso", "Cprocdet" as "Procesodetalle", "Orden" as "Orden", "Taller" as "Taller", "Invent" as "Inventarioentrada", "Invsal" as "Inventariosalida" from ZooLogic.GESTORDPRO where CodGestPro = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Procesos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Procesos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Procesos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Gesprodcur" as "Codigo", "Martdf" as "Articulo", "Descripdf" as "Articulodetalle", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Insumodet" as "Insumodetalle", "Codcolor" as "Color", "Fcoltxt" as "Colordetalle", "Codtalle" as "Talle", "Talledet" as "Talledetalle", "Partida" as "Partida", "Cantprod" as "Cantproducida", "Cantdesc" as "Cantdescarte" from ZooLogic.GESPCURV where GesProdCur = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionCurva')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionCurva', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionCurva
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Gesproddes" as "Codigo", "Martdf" as "Articulo", "Descripdf" as "Articulodetalle", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Insumodet" as "Insumodetalle", "Codcolor" as "Color", "Fcoltxt" as "Colordetalle", "Codtalle" as "Talle", "Italletxt" as "Talledetalle", "Partida" as "Partida", "Motdesc" as "Motdescarte", "Motdescdet" as "Motdescartedetalle", "Inventdest" as "Inventariodest", "Inventddet" as "Inventariodestdetalle", "Cantdesc" as "Cantdescarte" from ZooLogic.GESPDESC where GesProdDes = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionDescartes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionDescartes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionDescartes
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Cantunit" as "Cantporunidad", "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Gesprodins" as "Codigo", "Martdf" as "Articulo", "Descripdf" as "Articulodetalle", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Cinsdet" as "Insumodetalle", "Codcolor" as "Color", "Fcoltxt" as "Colordetalle", "Codtalle" as "Talle", "Italletxt" as "Talledetalle", "Partida" as "Partida", "Cantidad" as "Cantidad" from ZooLogic.GESPINS where GesProdIns = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Gesprodind" as "Codigo", "Martdf" as "Articulo", "Descripdf" as "Articulodetalle", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Cinsdet" as "Insumodetalle", "Codcolor" as "Color", "Fcoltxt" as "Colordetalle", "Codtalle" as "Talle", "Italletxt" as "Talledetalle", "Partida" as "Partida", "Cantidad" as "Cantidad" from ZooLogic.GESPIND where GesProdInD = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionInsumosDescartes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionInsumosDescartes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionInsumosDescartes
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
				select top 1 "Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Modelo" as "Modelo", "Codigo" as "Codigo", "Obs" as "Obs", "Numero" as "Numero", "Ffch" as "Fecha", "Ordendepro" as "Ordendeproduccion", "Proceso" as "Proceso", "Taller" as "Taller", "Inventorig" as "Inventarioorigen", "Inventdest" as "Inventariodestino" from ZooLogic.GESTIONPROD where  GESTIONPROD.CODIGO != '' order by Numero desc
			endtext
			use in select('c_GESTIONDEPRODUCCION')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GESTIONDEPRODUCCION', set( 'Datasession' ) )
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Nroitem" as "Nroitem", "Codgestpro" as "Codigo", "Codigo" as "Proceso", "Cprocdet" as "Procesodetalle", "Orden" as "Orden", "Taller" as "Taller", "Invent" as "Inventarioentrada", "Invsal" as "Inventariosalida" from ZooLogic.GESTORDPRO where CodGestPro = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_Procesos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_Procesos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_Procesos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Gesprodcur" as "Codigo", "Martdf" as "Articulo", "Descripdf" as "Articulodetalle", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Insumodet" as "Insumodetalle", "Codcolor" as "Color", "Fcoltxt" as "Colordetalle", "Codtalle" as "Talle", "Talledet" as "Talledetalle", "Partida" as "Partida", "Cantprod" as "Cantproducida", "Cantdesc" as "Cantdescarte" from ZooLogic.GESPCURV where GesProdCur = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionCurva')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionCurva', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionCurva
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Gesproddes" as "Codigo", "Martdf" as "Articulo", "Descripdf" as "Articulodetalle", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Insumodet" as "Insumodetalle", "Codcolor" as "Color", "Fcoltxt" as "Colordetalle", "Codtalle" as "Talle", "Italletxt" as "Talledetalle", "Partida" as "Partida", "Motdesc" as "Motdescarte", "Motdescdet" as "Motdescartedetalle", "Inventdest" as "Inventariodest", "Inventddet" as "Inventariodestdetalle", "Cantdesc" as "Cantdescarte" from ZooLogic.GESPDESC where GesProdDes = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionDescartes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionDescartes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionDescartes
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Cantunit" as "Cantporunidad", "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Gesprodins" as "Codigo", "Martdf" as "Articulo", "Descripdf" as "Articulodetalle", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Cinsdet" as "Insumodetalle", "Codcolor" as "Color", "Fcoltxt" as "Colordetalle", "Codtalle" as "Talle", "Italletxt" as "Talledetalle", "Partida" as "Partida", "Cantidad" as "Cantidad" from ZooLogic.GESPINS where GesProdIns = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionInsumos')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionInsumos', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionInsumos
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Gesprodind" as "Codigo", "Martdf" as "Articulo", "Descripdf" as "Articulodetalle", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Cinsdet" as "Insumodetalle", "Codcolor" as "Color", "Fcoltxt" as "Colordetalle", "Codtalle" as "Talle", "Italletxt" as "Talledetalle", "Partida" as "Partida", "Cantidad" as "Cantidad" from ZooLogic.GESPIND where GesProdInD = <<"'" + this.FormatearTextoSql( c_GESTIONDEPRODUCCION.CODIGO ) + "'">> Order by NroItem
			endtext
			use in select('c_GestionInsumosDescartes')
			this.oConexion.EjecutarSql( lcSentencia, 'c_GestionInsumosDescartes', set( 'Datasession' ) )
				Replace all NroItem with recno() in c_GestionInsumosDescartes
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
			lcXml = this.oConexion.EjecutarSql( "select Fectrans,Faltafw,Fmodifw,Fecimpo,Fecexpo,Haltafw,Horaexpo,Hmodifw,Vmodifw,Zadsfw,Valtafw,Ual" + ;
"tafw,Umodifw,Saltafw,Smodifw,Horaimpo,Bdmodifw,Esttrans,Bdaltafw,Modelo,Codigo,Obs,Numero,Ffch,Orden" + ;
"depro,Proceso,Taller,Inventorig,Inventdest" + ;
" from ZooLogic.GESTIONPROD where  GESTIONPROD.CODIGO != '' and " + lcFiltro )
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
			local  lxGestionprodFectrans, lxGestionprodFaltafw, lxGestionprodFmodifw, lxGestionprodFecimpo, lxGestionprodFecexpo, lxGestionprodHaltafw, lxGestionprodHoraexpo, lxGestionprodHmodifw, lxGestionprodVmodifw, lxGestionprodZadsfw, lxGestionprodValtafw, lxGestionprodUaltafw, lxGestionprodUmodifw, lxGestionprodSaltafw, lxGestionprodSmodifw, lxGestionprodHoraimpo, lxGestionprodBdmodifw, lxGestionprodEsttrans, lxGestionprodBdaltafw, lxGestionprodModelo, lxGestionprodCodigo, lxGestionprodObs, lxGestionprodNumero, lxGestionprodFfch, lxGestionprodOrdendepro, lxGestionprodProceso, lxGestionprodTaller, lxGestionprodInventorig, lxGestionprodInventdest
				lxGestionprodFectrans = ctod( '  /  /    ' )			lxGestionprodFaltafw = ctod( '  /  /    ' )			lxGestionprodFmodifw = ctod( '  /  /    ' )			lxGestionprodFecimpo = ctod( '  /  /    ' )			lxGestionprodFecexpo = ctod( '  /  /    ' )			lxGestionprodHaltafw = []			lxGestionprodHoraexpo = []			lxGestionprodHmodifw = []			lxGestionprodVmodifw = []			lxGestionprodZadsfw = []			lxGestionprodValtafw = []			lxGestionprodUaltafw = []			lxGestionprodUmodifw = []			lxGestionprodSaltafw = []			lxGestionprodSmodifw = []			lxGestionprodHoraimpo = []			lxGestionprodBdmodifw = []			lxGestionprodEsttrans = []			lxGestionprodBdaltafw = []			lxGestionprodModelo = []			lxGestionprodCodigo = []			lxGestionprodObs = []			lxGestionprodNumero = 0			lxGestionprodFfch = ctod( '  /  /    ' )			lxGestionprodOrdendepro = []			lxGestionprodProceso = []			lxGestionprodTaller = []			lxGestionprodInventorig = []			lxGestionprodInventdest = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.GESTORDPRO where "CodGestPro" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.GESPCURV where "GesProdCur" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.GESPDESC where "GesProdDes" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.GESPINS where "GesProdIns" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( 'delete from ZooLogic.GESPIND where "GesProdInD" = ' + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'" )
			this.oConexion.EjecutarSql( [delete from ZooLogic.GESTIONPROD where "CODIGO" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'"+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'GESTIONPROD' + '_' + tcCampo
			lcMemoAscii = ''

			lnIndice = alen(.aSqlMemos)
			lnIndice = iif(lnIndice = 1, 1, lnIndice + 1 )
			dimension .aSqlMemos(lnIndice)

			.aSqlMemos(lnIndice) = 'delete from ' + lcTabla + ' where CODIGO = ' + txValorClavePrimaria
			.GenerarSentenciasInsertTablaMemo( lcValor, lcTabla, txValorClavePrimaria )
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerSentenciaInsertMemo( tcTabla as String, txValorClavePrimaria as String, tcOrden as String, tcTexto as String ) as String
		return "Insert  into " + tcTabla + "(CODIGO, Orden, texto ) values ( " + txValorClavePrimaria + "," + tcOrden + ",'"+ tcTexto + "')"
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosEntidad( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  GESTIONPROD.CODIGO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Modelo" as "Modelo", "Codigo" as "Codigo", "Obs" as "Obs", "Numero" as "Numero", "Ffch" as "Fecha", "Ordendepro" as "Ordendeproduccion", "Proceso" as "Proceso", "Taller" as "Taller", "Inventorig" as "Inventarioorigen", "Inventdest" as "Inventariodestino"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'GESTIONPROD', '', tnTope )
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
		lcWhere = " Where  GESTORDPRO.CODGESTPRO != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Nroitem" as "Nroitem", "Codgestpro" as "Codigo", "Codigo" as "Proceso", "Cprocdet" as "Procesodetalle", "Orden" as "Orden", "Taller" as "Taller", "Invent" as "Inventarioentrada", "Invsal" as "Inventariosalida"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleProcesos( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'GESTORDPRO', 'Procesos', tnTope )
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
	Function ObtenerDatosDetalleGestionCurva( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  GESPCURV.GESPRODCUR != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Iditem" as "Iditeminsumo", "Nroitem" as "Nroitem", "Comp" as "Comportamiento", "Gesprodcur" as "Codigo", "Martdf" as "Articulo", "Descripdf" as "Articulodetalle", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Insumodet" as "Insumodetalle", "Codcolor" as "Color", "Fcoltxt" as "Colordetalle", "Codtalle" as "Talle", "Talledet" as "Talledetalle", "Partida" as "Partida", "Cantprod" as "Cantproducida", "Cantdesc" as "Cantdescarte"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleGestionCurva( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'GESPCURV', 'GestionCurva', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleGestionCurva( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleGestionCurva( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleGestionDescartes( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  GESPDESC.GESPRODDES != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Gesproddes" as "Codigo", "Martdf" as "Articulo", "Descripdf" as "Articulodetalle", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Insumodet" as "Insumodetalle", "Codcolor" as "Color", "Fcoltxt" as "Colordetalle", "Codtalle" as "Talle", "Italletxt" as "Talledetalle", "Partida" as "Partida", "Motdesc" as "Motdescarte", "Motdescdet" as "Motdescartedetalle", "Inventdest" as "Inventariodest", "Inventddet" as "Inventariodestdetalle", "Cantdesc" as "Cantdescarte"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleGestionDescartes( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'GESPDESC', 'GestionDescartes', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleGestionDescartes( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleGestionDescartes( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleGestionInsumos( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  GESPINS.GESPRODINS != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Cantunit" as "Cantporunidad", "Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Gesprodins" as "Codigo", "Martdf" as "Articulo", "Descripdf" as "Articulodetalle", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Cinsdet" as "Insumodetalle", "Codcolor" as "Color", "Fcoltxt" as "Colordetalle", "Codtalle" as "Talle", "Italletxt" as "Talledetalle", "Partida" as "Partida", "Cantidad" as "Cantidad"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleGestionInsumos( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'GESPINS', 'GestionInsumos', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleGestionInsumos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleGestionInsumos( lcAtributo )
		endfor
		lcSelect = substr( lcSelect, 2 )
		return lcSelect
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function ObtenerDatosDetalleGestionInsumosDescartes( tcAtributos As String, tcHaving As String, tcOrder As String, tcFunc As String, tnTope as Integer ) As String
		Local lcAtributos As String, lcWhere As String
		lcWhere = " Where  GESPIND.GESPRODIND != ''"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Iditem" as "Iditeminsumo", "Comp" as "Comportamiento", "Nroitem" as "Nroitem", "Gesprodind" as "Codigo", "Martdf" as "Articulo", "Descripdf" as "Articulodetalle", "Ccolor" as "Colorm", "Ccoldet" as "Colormdetalle", "Ctalle" as "Tallem", "Ctalledet" as "Tallemdetalle", "Insumo" as "Insumo", "Cinsdet" as "Insumodetalle", "Codcolor" as "Color", "Fcoltxt" as "Colordetalle", "Codtalle" as "Talle", "Italletxt" as "Talledetalle", "Partida" as "Partida", "Cantidad" as "Cantidad"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectDetalleGestionInsumosDescartes( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'GESPIND', 'GestionInsumosDescartes', tnTope )
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ParsearCamposDetalleGestionInsumosDescartes( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String
		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			lcSelect = lcSelect + ',' + this.ObtenerCampoDetalleGestionInsumosDescartes( lcAtributo )
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
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
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
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'MODELO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MODELO AS MODELO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'OBS AS OBS'
				Case lcAtributo == 'NUMERO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NUMERO AS NUMERO'
				Case lcAtributo == 'FECHA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FFCH AS FECHA'
				Case lcAtributo == 'ORDENDEPRODUCCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ORDENDEPRO AS ORDENDEPRODUCCION'
				Case lcAtributo == 'PROCESO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROCESO AS PROCESO'
				Case lcAtributo == 'TALLER'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLER AS TALLER'
				Case lcAtributo == 'INVENTARIOORIGEN'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INVENTORIG AS INVENTARIOORIGEN'
				Case lcAtributo == 'INVENTARIODESTINO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INVENTDEST AS INVENTARIODESTINO'
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
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODGESTPRO AS CODIGO'
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
	Function ObtenerCamposSelectDetalleGestionCurva( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'IDITEMINSUMO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEM AS IDITEMINSUMO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GESPRODCUR AS CODIGO'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MARTDF AS ARTICULO'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIPDF AS ARTICULODETALLE'
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
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INSUMODET AS INSUMODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCOLOR AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOLTXT AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODTALLE AS TALLE'
				Case lcAtributo == 'TALLEDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALLEDET AS TALLEDETALLE'
				Case lcAtributo == 'PARTIDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PARTIDA AS PARTIDA'
				Case lcAtributo == 'CANTPRODUCIDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTPROD AS CANTPRODUCIDA'
				Case lcAtributo == 'CANTDESCARTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTDESC AS CANTDESCARTE'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleGestionDescartes( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'IDITEMINSUMO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEM AS IDITEMINSUMO'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GESPRODDES AS CODIGO'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MARTDF AS ARTICULO'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIPDF AS ARTICULODETALLE'
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
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INSUMODET AS INSUMODETALLE'
				Case lcAtributo == 'COLOR'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCOLOR AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOLTXT AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODTALLE AS TALLE'
				Case lcAtributo == 'TALLEDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ITALLETXT AS TALLEDETALLE'
				Case lcAtributo == 'PARTIDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PARTIDA AS PARTIDA'
				Case lcAtributo == 'MOTDESCARTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTDESC AS MOTDESCARTE'
				Case lcAtributo == 'MOTDESCARTEDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOTDESCDET AS MOTDESCARTEDETALLE'
				Case lcAtributo == 'INVENTARIODEST'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INVENTDEST AS INVENTARIODEST'
				Case lcAtributo == 'INVENTARIODESTDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'INVENTDDET AS INVENTARIODESTDETALLE'
				Case lcAtributo == 'CANTDESCARTE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTDESC AS CANTDESCARTE'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleGestionInsumos( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'CANTPORUNIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTUNIT AS CANTPORUNIDAD'
				Case lcAtributo == 'IDITEMINSUMO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEM AS IDITEMINSUMO'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GESPRODINS AS CODIGO'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MARTDF AS ARTICULO'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIPDF AS ARTICULODETALLE'
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
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCOLOR AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOLTXT AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODTALLE AS TALLE'
				Case lcAtributo == 'TALLEDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ITALLETXT AS TALLEDETALLE'
				Case lcAtributo == 'PARTIDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PARTIDA AS PARTIDA'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTIDAD AS CANTIDAD'
			EndCase
		EndFor
		Return lcSelect
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCamposSelectDetalleGestionInsumosDescartes( tcCampos As String ) As String
		local i As Integer, lcSelect As String , lcAtributo As String

		lcSelect = ''
		for i = 1 To getwordcount( tcCampos, ',' )
			lcAtributo = upper( alltrim( getwordnum( tcCampos, i, ',' ) ) )
			Do Case
				Case lcAtributo == 'IDITEMINSUMO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'IDITEM AS IDITEMINSUMO'
				Case lcAtributo == 'COMPORTAMIENTO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COMP AS COMPORTAMIENTO'
				Case lcAtributo == 'NROITEM'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'NROITEM AS NROITEM'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GESPRODIND AS CODIGO'
				Case lcAtributo == 'ARTICULO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MARTDF AS ARTICULO'
				Case lcAtributo == 'ARTICULODETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIPDF AS ARTICULODETALLE'
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
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODCOLOR AS COLOR'
				Case lcAtributo == 'COLORDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FCOLTXT AS COLORDETALLE'
				Case lcAtributo == 'TALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODTALLE AS TALLE'
				Case lcAtributo == 'TALLEDETALLE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ITALLETXT AS TALLEDETALLE'
				Case lcAtributo == 'PARTIDA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PARTIDA AS PARTIDA'
				Case lcAtributo == 'CANTIDAD'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CANTIDAD AS CANTIDAD'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
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
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'MODELO'
				lcCampo = 'MODELO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'OBS'
			Case upper( alltrim( tcAtributo ) ) == 'NUMERO'
				lcCampo = 'NUMERO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHA'
				lcCampo = 'FFCH'
			Case upper( alltrim( tcAtributo ) ) == 'ORDENDEPRODUCCION'
				lcCampo = 'ORDENDEPRO'
			Case upper( alltrim( tcAtributo ) ) == 'PROCESO'
				lcCampo = 'PROCESO'
			Case upper( alltrim( tcAtributo ) ) == 'TALLER'
				lcCampo = 'TALLER'
			Case upper( alltrim( tcAtributo ) ) == 'INVENTARIOORIGEN'
				lcCampo = 'INVENTORIG'
			Case upper( alltrim( tcAtributo ) ) == 'INVENTARIODESTINO'
				lcCampo = 'INVENTDEST'
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
				lcCampo = 'CODGESTPRO'
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
	Function ObtenerCampoDetalleGestionCurva( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMINSUMO'
				lcCampo = 'IDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'GESPRODCUR'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'MARTDF'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'DESCRIPDF'
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
				lcCampo = 'INSUMODET'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'CODCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'FCOLTXT'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'CODTALLE'
			Case upper( alltrim( tcAtributo ) ) == 'TALLEDETALLE'
				lcCampo = 'TALLEDET'
			Case upper( alltrim( tcAtributo ) ) == 'PARTIDA'
				lcCampo = 'PARTIDA'
			Case upper( alltrim( tcAtributo ) ) == 'CANTPRODUCIDA'
				lcCampo = 'CANTPROD'
			Case upper( alltrim( tcAtributo ) ) == 'CANTDESCARTE'
				lcCampo = 'CANTDESC'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleGestionDescartes( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMINSUMO'
				lcCampo = 'IDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'GESPRODDES'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'MARTDF'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'DESCRIPDF'
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
				lcCampo = 'INSUMODET'
			Case upper( alltrim( tcAtributo ) ) == 'COLOR'
				lcCampo = 'CODCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'FCOLTXT'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'CODTALLE'
			Case upper( alltrim( tcAtributo ) ) == 'TALLEDETALLE'
				lcCampo = 'ITALLETXT'
			Case upper( alltrim( tcAtributo ) ) == 'PARTIDA'
				lcCampo = 'PARTIDA'
			Case upper( alltrim( tcAtributo ) ) == 'MOTDESCARTE'
				lcCampo = 'MOTDESC'
			Case upper( alltrim( tcAtributo ) ) == 'MOTDESCARTEDETALLE'
				lcCampo = 'MOTDESCDET'
			Case upper( alltrim( tcAtributo ) ) == 'INVENTARIODEST'
				lcCampo = 'INVENTDEST'
			Case upper( alltrim( tcAtributo ) ) == 'INVENTARIODESTDETALLE'
				lcCampo = 'INVENTDDET'
			Case upper( alltrim( tcAtributo ) ) == 'CANTDESCARTE'
				lcCampo = 'CANTDESC'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleGestionInsumos( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'CANTPORUNIDAD'
				lcCampo = 'CANTUNIT'
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMINSUMO'
				lcCampo = 'IDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'GESPRODINS'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'MARTDF'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'DESCRIPDF'
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
				lcCampo = 'CODCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'FCOLTXT'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'CODTALLE'
			Case upper( alltrim( tcAtributo ) ) == 'TALLEDETALLE'
				lcCampo = 'ITALLETXT'
			Case upper( alltrim( tcAtributo ) ) == 'PARTIDA'
				lcCampo = 'PARTIDA'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'CANTIDAD'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ObtenerCampoDetalleGestionInsumosDescartes( tcAtributo As String ) As String
		local i As Integer, lcCampo As String

		lcCampo = ''
		Do Case
			Case upper( alltrim( tcAtributo ) ) == 'IDITEMINSUMO'
				lcCampo = 'IDITEM'
			Case upper( alltrim( tcAtributo ) ) == 'COMPORTAMIENTO'
				lcCampo = 'COMP'
			Case upper( alltrim( tcAtributo ) ) == 'NROITEM'
				lcCampo = 'NROITEM'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'GESPRODIND'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULO'
				lcCampo = 'MARTDF'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODETALLE'
				lcCampo = 'DESCRIPDF'
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
				lcCampo = 'CODCOLOR'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDETALLE'
				lcCampo = 'FCOLTXT'
			Case upper( alltrim( tcAtributo ) ) == 'TALLE'
				lcCampo = 'CODTALLE'
			Case upper( alltrim( tcAtributo ) ) == 'TALLEDETALLE'
				lcCampo = 'ITALLETXT'
			Case upper( alltrim( tcAtributo ) ) == 'PARTIDA'
				lcCampo = 'PARTIDA'
			Case upper( alltrim( tcAtributo ) ) == 'CANTIDAD'
				lcCampo = 'CANTIDAD'
			EndCase
		Return lcCampo
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerTablaDetalle( tcDetalle as string ) as String
		local lcRetorno as string
		lcRetorno = ''
		if upper( alltrim( tcDetalle ) ) == 'PROCESOS'
			lcRetorno = 'GESTORDPRO'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'GESTIONCURVA'
			lcRetorno = 'GESPCURV'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'GESTIONDESCARTES'
			lcRetorno = 'GESPDESC'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'GESTIONINSUMOS'
			lcRetorno = 'GESPINS'
		EndIf
		if upper( alltrim( tcDetalle ) ) == 'GESTIONINSUMOSDESCARTES'
			lcRetorno = 'GESPIND'
		EndIf
		return lcRetorno
	EndFunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasInsert() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcSentencia as string, loItem as object
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxGestionprodFectrans, lxGestionprodFaltafw, lxGestionprodFmodifw, lxGestionprodFecimpo, lxGestionprodFecexpo, lxGestionprodHaltafw, lxGestionprodHoraexpo, lxGestionprodHmodifw, lxGestionprodVmodifw, lxGestionprodZadsfw, lxGestionprodValtafw, lxGestionprodUaltafw, lxGestionprodUmodifw, lxGestionprodSaltafw, lxGestionprodSmodifw, lxGestionprodHoraimpo, lxGestionprodBdmodifw, lxGestionprodEsttrans, lxGestionprodBdaltafw, lxGestionprodModelo, lxGestionprodCodigo, lxGestionprodObs, lxGestionprodNumero, lxGestionprodFfch, lxGestionprodOrdendepro, lxGestionprodProceso, lxGestionprodTaller, lxGestionprodInventorig, lxGestionprodInventdest
				lxGestionprodFectrans =  .Fechatransferencia			lxGestionprodFaltafw =  .Fechaaltafw			lxGestionprodFmodifw =  .Fechamodificacionfw			lxGestionprodFecimpo =  .Fechaimpo			lxGestionprodFecexpo =  .Fechaexpo			lxGestionprodHaltafw =  .Horaaltafw			lxGestionprodHoraexpo =  .Horaexpo			lxGestionprodHmodifw =  .Horamodificacionfw			lxGestionprodVmodifw =  .Versionmodificacionfw			lxGestionprodZadsfw =  .Zadsfw			lxGestionprodValtafw =  .Versionaltafw			lxGestionprodUaltafw =  .Usuarioaltafw			lxGestionprodUmodifw =  .Usuariomodificacionfw			lxGestionprodSaltafw =  .Seriealtafw			lxGestionprodSmodifw =  .Seriemodificacionfw			lxGestionprodHoraimpo =  .Horaimpo			lxGestionprodBdmodifw =  .Basededatosmodificacionfw			lxGestionprodEsttrans =  .Estadotransferencia			lxGestionprodBdaltafw =  .Basededatosaltafw			lxGestionprodModelo =  upper( .Modelo_PK ) 			lxGestionprodCodigo =  .Codigo			lxGestionprodObs =  .Obs			lxGestionprodNumero =  .Numero			lxGestionprodFfch =  .Fecha			lxGestionprodOrdendepro =  upper( .OrdenDeProduccion_PK ) 			lxGestionprodProceso =  upper( .Proceso_PK ) 			lxGestionprodTaller =  upper( .Taller_PK ) 			lxGestionprodInventorig =  upper( .InventarioOrigen_PK ) 			lxGestionprodInventdest =  upper( .InventarioDestino_PK ) 
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.GESTIONPROD ( "Fectrans","Faltafw","Fmodifw","Fecimpo","Fecexpo","Haltafw","Horaexpo","Hmodifw","Vmodifw","Zadsfw","Valtafw","Ualtafw","Umodifw","Saltafw","Smodifw","Horaimpo","Bdmodifw","Esttrans","Bdaltafw","Modelo","Codigo","Obs","Numero","Ffch","Ordendepro","Proceso","Taller","Inventorig","Inventdest" ) values ( <<"'" + this.ConvertirDateSql( lxGestionprodFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxGestionprodFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxGestionprodFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxGestionprodFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxGestionprodFecexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodModelo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodCodigo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodObs ) + "'" >>, <<lxGestionprodNumero >>, <<"'" + this.ConvertirDateSql( lxGestionprodFfch ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodOrdendepro ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodProceso ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodTaller ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodInventorig ) + "'" >>, <<"'" + this.FormatearTextoSql( lxGestionprodInventdest ) + "'" >> )
		endtext
		loColeccion.cTabla = 'GESTIONPROD' 
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
					lxProcesodetalle = loItem.Procesodetalle
					lxOrden = loItem.Orden
					lxTaller_PK = loItem.Taller_PK
					lxInventarioentrada_PK = loItem.Inventarioentrada_PK
					lxInventariosalida_PK = loItem.Inventariosalida_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.GESTORDPRO("NROITEM","CodGestPro","Codigo","cProcDet","Orden","Taller","InvEnt","InvSal" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<lxOrden>>, <<"'" + this.FormatearTextoSql( lxTaller_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventarioentrada_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventariosalida_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.GestionCurva
				if this.oEntidad.GestionCurva.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxNroitem = lnContadorNroItem
					lxComportamiento = loItem.Comportamiento
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
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
					lxPartida = loItem.Partida
					lxCantproducida = loItem.Cantproducida
					lxCantdescarte = loItem.Cantdescarte
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.GESPCURV("IdItem","NROITEM","COMP","GesProdCur","MARTDF","DESCRIPDF","cColor","cColDet","cTalle","cTalleDet","Insumo","InsumoDet","CodColor","FCOLTXT","CodTalle","TalleDet","Partida","CantProd","CantDesc" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxNroitem>>, <<lxComportamiento>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxPartida ) + "'">>, <<lxCantproducida>>, <<lxCantdescarte>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.GestionDescartes
				if this.oEntidad.GestionDescartes.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
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
					lxPartida = loItem.Partida
					lxMotdescarte_PK = loItem.Motdescarte_PK
					lxMotdescartedetalle = loItem.Motdescartedetalle
					lxInventariodest_PK = loItem.Inventariodest_PK
					lxInventariodestdetalle = loItem.Inventariodestdetalle
					lxCantdescarte = loItem.Cantdescarte
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.GESPDESC("IdItem","COMP","NROITEM","GesProdDes","MARTDF","DESCRIPDF","cColor","cColDet","cTalle","cTalleDet","Insumo","InsumoDet","CodColor","FCOLTXT","CodTalle","ITalleTxt","Partida","MotDesc","MotDescDet","InventDest","InventDDet","CantDesc" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxPartida ) + "'">>, <<"'" + this.FormatearTextoSql( lxMotdescarte_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxMotdescartedetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventariodest_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventariodestdetalle ) + "'">>, <<lxCantdescarte>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.GestionInsumos
				if this.oEntidad.GestionInsumos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxCantporunidad = loItem.Cantporunidad
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
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
					lxPartida = loItem.Partida
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.GESPINS("CantUnit","IdItem","COMP","NROITEM","GesProdIns","MARTDF","DESCRIPDF","cColor","cColDet","cTalle","cTalleDet","Insumo","cInsDet","CodColor","FCOLTXT","CodTalle","ITalleTxt","Partida","Cantidad" ) values ( <<lxCantporunidad>>, <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxPartida ) + "'">>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.GestionInsumosDescartes
				if this.oEntidad.GestionInsumosDescartes.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
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
					lxPartida = loItem.Partida
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.GESPIND("IdItem","COMP","NROITEM","GesProdInD","MARTDF","DESCRIPDF","cColor","cColDet","cTalle","cTalleDet","Insumo","cInsDet","CodColor","FCOLTXT","CodTalle","ITalleTxt","Partida","Cantidad" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxPartida ) + "'">>, <<lxCantidad>> ) 
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
			local  lxGestionprodFectrans, lxGestionprodFaltafw, lxGestionprodFmodifw, lxGestionprodFecimpo, lxGestionprodFecexpo, lxGestionprodHaltafw, lxGestionprodHoraexpo, lxGestionprodHmodifw, lxGestionprodVmodifw, lxGestionprodZadsfw, lxGestionprodValtafw, lxGestionprodUaltafw, lxGestionprodUmodifw, lxGestionprodSaltafw, lxGestionprodSmodifw, lxGestionprodHoraimpo, lxGestionprodBdmodifw, lxGestionprodEsttrans, lxGestionprodBdaltafw, lxGestionprodModelo, lxGestionprodCodigo, lxGestionprodObs, lxGestionprodNumero, lxGestionprodFfch, lxGestionprodOrdendepro, lxGestionprodProceso, lxGestionprodTaller, lxGestionprodInventorig, lxGestionprodInventdest
				lxGestionprodFectrans =  .Fechatransferencia			lxGestionprodFaltafw =  .Fechaaltafw			lxGestionprodFmodifw =  .Fechamodificacionfw			lxGestionprodFecimpo =  .Fechaimpo			lxGestionprodFecexpo =  .Fechaexpo			lxGestionprodHaltafw =  .Horaaltafw			lxGestionprodHoraexpo =  .Horaexpo			lxGestionprodHmodifw =  .Horamodificacionfw			lxGestionprodVmodifw =  .Versionmodificacionfw			lxGestionprodZadsfw =  .Zadsfw			lxGestionprodValtafw =  .Versionaltafw			lxGestionprodUaltafw =  .Usuarioaltafw			lxGestionprodUmodifw =  .Usuariomodificacionfw			lxGestionprodSaltafw =  .Seriealtafw			lxGestionprodSmodifw =  .Seriemodificacionfw			lxGestionprodHoraimpo =  .Horaimpo			lxGestionprodBdmodifw =  .Basededatosmodificacionfw			lxGestionprodEsttrans =  .Estadotransferencia			lxGestionprodBdaltafw =  .Basededatosaltafw			lxGestionprodModelo =  upper( .Modelo_PK ) 			lxGestionprodCodigo =  .Codigo			lxGestionprodObs =  .Obs			lxGestionprodNumero =  .Numero			lxGestionprodFfch =  .Fecha			lxGestionprodOrdendepro =  upper( .OrdenDeProduccion_PK ) 			lxGestionprodProceso =  upper( .Proceso_PK ) 			lxGestionprodTaller =  upper( .Taller_PK ) 			lxGestionprodInventorig =  upper( .InventarioOrigen_PK ) 			lxGestionprodInventdest =  upper( .InventarioDestino_PK ) 
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = "'" + this.oEntidad.CODIGO + "'"

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  GESTIONPROD.CODIGO != '']
			text to lcSentencia noshow textmerge
				update ZooLogic.GESTIONPROD set "Fectrans" = <<"'" + this.ConvertirDateSql( lxGestionprodFectrans ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxGestionprodFaltafw ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxGestionprodFmodifw ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxGestionprodFecimpo ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxGestionprodFecexpo ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxGestionprodHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxGestionprodHoraexpo ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxGestionprodHmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxGestionprodVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxGestionprodZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxGestionprodValtafw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxGestionprodUaltafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxGestionprodUmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxGestionprodSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxGestionprodSmodifw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxGestionprodHoraimpo ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxGestionprodBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxGestionprodEsttrans ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxGestionprodBdaltafw ) + "'">>, "Modelo" = <<"'" + this.FormatearTextoSql( lxGestionprodModelo ) + "'">>, "Codigo" = <<"'" + this.FormatearTextoSql( lxGestionprodCodigo ) + "'">>, "Obs" = <<"'" + this.FormatearTextoSql( lxGestionprodObs ) + "'">>, "Numero" = <<lxGestionprodNumero>>, "Ffch" = <<"'" + this.ConvertirDateSql( lxGestionprodFfch ) + "'">>, "Ordendepro" = <<"'" + this.FormatearTextoSql( lxGestionprodOrdendepro ) + "'">>, "Proceso" = <<"'" + this.FormatearTextoSql( lxGestionprodProceso ) + "'">>, "Taller" = <<"'" + this.FormatearTextoSql( lxGestionprodTaller ) + "'">>, "Inventorig" = <<"'" + this.FormatearTextoSql( lxGestionprodInventorig ) + "'">>, "Inventdest" = <<"'" + this.FormatearTextoSql( lxGestionprodInventdest ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'GESTIONPROD' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
			loColeccion.Agregar([delete from ZooLogic.GESTORDPRO where "CodGestPro" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.GESPCURV where "GesProdCur" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.GESPDESC where "GesProdDes" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.GESPINS where "GesProdIns" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.GESPIND where "GesProdInD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.Procesos
				if this.oEntidad.Procesos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxNroitem = lnContadorNroItem
					lxProceso_PK = loItem.Proceso_PK
					lxProcesodetalle = loItem.Procesodetalle
					lxOrden = loItem.Orden
					lxTaller_PK = loItem.Taller_PK
					lxInventarioentrada_PK = loItem.Inventarioentrada_PK
					lxInventariosalida_PK = loItem.Inventariosalida_PK
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.GESTORDPRO("NROITEM","CodGestPro","Codigo","cProcDet","Orden","Taller","InvEnt","InvSal" ) values ( <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxProceso_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxProcesodetalle ) + "'">>, <<lxOrden>>, <<"'" + this.FormatearTextoSql( lxTaller_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventarioentrada_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventariosalida_PK ) + "'">> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.GestionCurva
				if this.oEntidad.GestionCurva.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxNroitem = lnContadorNroItem
					lxComportamiento = loItem.Comportamiento
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
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
					lxPartida = loItem.Partida
					lxCantproducida = loItem.Cantproducida
					lxCantdescarte = loItem.Cantdescarte
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.GESPCURV("IdItem","NROITEM","COMP","GesProdCur","MARTDF","DESCRIPDF","cColor","cColDet","cTalle","cTalleDet","Insumo","InsumoDet","CodColor","FCOLTXT","CodTalle","TalleDet","Partida","CantProd","CantDesc" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxNroitem>>, <<lxComportamiento>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxPartida ) + "'">>, <<lxCantproducida>>, <<lxCantdescarte>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.GestionDescartes
				if this.oEntidad.GestionDescartes.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
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
					lxPartida = loItem.Partida
					lxMotdescarte_PK = loItem.Motdescarte_PK
					lxMotdescartedetalle = loItem.Motdescartedetalle
					lxInventariodest_PK = loItem.Inventariodest_PK
					lxInventariodestdetalle = loItem.Inventariodestdetalle
					lxCantdescarte = loItem.Cantdescarte
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.GESPDESC("IdItem","COMP","NROITEM","GesProdDes","MARTDF","DESCRIPDF","cColor","cColDet","cTalle","cTalleDet","Insumo","InsumoDet","CodColor","FCOLTXT","CodTalle","ITalleTxt","Partida","MotDesc","MotDescDet","InventDest","InventDDet","CantDesc" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxPartida ) + "'">>, <<"'" + this.FormatearTextoSql( lxMotdescarte_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxMotdescartedetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventariodest_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInventariodestdetalle ) + "'">>, <<lxCantdescarte>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.GestionInsumos
				if this.oEntidad.GestionInsumos.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxCantporunidad = loItem.Cantporunidad
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
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
					lxPartida = loItem.Partida
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.GESPINS("CantUnit","IdItem","COMP","NROITEM","GesProdIns","MARTDF","DESCRIPDF","cColor","cColDet","cTalle","cTalleDet","Insumo","cInsDet","CodColor","FCOLTXT","CodTalle","ITalleTxt","Partida","Cantidad" ) values ( <<lxCantporunidad>>, <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxPartida ) + "'">>, <<lxCantidad>> ) 
					endtext
					loColeccion.Agregar( strtran( lcCadena, chr(9), '' ) )

					lnContadorNroItem = lnContadorNroItem + 1
				endif
			endfor

			local loItem as object, lnContadorNroItem as integer
			lnContadorNroItem = 1
			for each loItem in this.oEntidad.GestionInsumosDescartes
				if this.oEntidad.GestionInsumosDescartes.ValidarExistenciaCamposFijosItemPlano( loItem.NroItem )
					
					lxIditeminsumo = loItem.Iditeminsumo
					lxComportamiento = loItem.Comportamiento
					lxNroitem = lnContadorNroItem
					lxArticulo_PK = loItem.Articulo_PK
					lxArticulodetalle = loItem.Articulodetalle
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
					lxPartida = loItem.Partida
					lxCantidad = loItem.Cantidad
					Text to lcCadena noshow textmerge
						Insert into ZooLogic.GESPIND("IdItem","COMP","NROITEM","GesProdInD","MARTDF","DESCRIPDF","cColor","cColDet","cTalle","cTalleDet","Insumo","cInsDet","CodColor","FCOLTXT","CodTalle","ITalleTxt","Partida","Cantidad" ) values ( <<"'" + this.FormatearTextoSql( lxIditeminsumo ) + "'">>, <<lxComportamiento>>, <<lxNroitem>>, << lcValorClavePrimariaString >>, <<"'" + this.FormatearTextoSql( lxArticulo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxArticulodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColorm_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColormdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallem_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTallemdetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumo_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxInsumodetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxColor_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxColordetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalle_PK ) + "'">>, <<"'" + this.FormatearTextoSql( lxTalledetalle ) + "'">>, <<"'" + this.FormatearTextoSql( lxPartida ) + "'">>, <<lxCantidad>> ) 
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

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  GESTIONPROD.CODIGO != '']
		loColeccion.Agregar( 'delete from ZooLogic.GESTIONPROD where ' + lcFiltro )
			loColeccion.Agregar([delete from ZooLogic.GESTORDPRO where "CodGestPro" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.GESPCURV where "GesProdCur" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.GESPDESC where "GesProdDes" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.GESPINS where "GesProdIns" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.Agregar([delete from ZooLogic.GESPIND where "GesProdInD" = ] + "'" + this.FormatearTextoSql( .oEntidad.CODIGO ) + "'")
			loColeccion.cTabla = 'GESTIONPROD' 
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
		
			.oCompGestiondeproduccion.lNuevo = .EsNuevo()
			.oCompGestiondeproduccion.lEdicion = .EsEdicion()
			.oCompGestiondeproduccion.lEliminar = .lEliminar
			.oCompGestiondeproduccion.lAnular = .lAnular
			loColSentencias = .oCompGestiondeproduccion.grabar()
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
			lcRetorno = [update ZooLogic.GESTIONPROD set TimeStamp = ] + transform( lnTimeStamp ) + lcUpdateRealTime + [ where CODIGO = ] + "'" + this.FormatearTextoSql( .Codigo ) + "'" + [ and  GESTIONPROD.CODIGO != ''] + goServicios.RealTime.ObtenerTagEstimulo( .cNombre )
		
		endwith
		return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerCantidadRegistros() as integer
		local lnCantReg as integer
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.GESTIONPROD where  GESTIONPROD.CODIGO != ''" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.GESTIONPROD where CODIGO = " + "'" + this.FormatearTextoSql( this.oEntidad.CODIGO ) + "'"+ " and  GESTIONPROD.CODIGO != ''" )
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
		local lcCursor as String, ldFecha as Date, lcHora as string, lcValorABuscar As String, lxValorClavePK As variant, lxValorClavePrimaria As variant, lcIdentificadorParaLoguear as string, lxGESTIONPRODNumero as variant, lcMensajeExtra as String
		lcValorABuscar = ''
		lxValorClavePK = ''
		lcMensajeExtra = ''
		lcCursor = This.oEntidad.cPrefijoRecibir + 'GESTIONDEPRODUCCION'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.GESTIONPROD Where  Numero = ] + transform( &lcCursor..Numero     ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				lxValorClavePK = &lcCursor..CODIGO
				if lxValorClavePK == curSeek.CODIGO or this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
					if lxValorClavePK != curSeek.CODIGO and this.oEntidad.lIgnorarClaveprimariaEnRecepcionBD 
						lcValorABuscar = curSeek.CODIGO
					else 
						lcValorABuscar = lxValorClavePK 
					endif 
					if This.ActualizaEnRecepcion() 
						Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
						this.oConexion.EjecutarSql( [UPDATE ZooLogic.GESTIONPROD set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, Modelo = ] + "'" + this.FormatearTextoSql( &lcCursor..Modelo ) + "'"+ [, CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"+ [, Obs = ] + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'"+ [, Numero = ] + transform( &lcCursor..Numero )+ [, FFCH = ] + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'"+ [, OrdenDePro = ] + "'" + this.FormatearTextoSql( &lcCursor..OrdenDePro ) + "'"+ [, Proceso = ] + "'" + this.FormatearTextoSql( &lcCursor..Proceso ) + "'"+ [, Taller = ] + "'" + this.FormatearTextoSql( &lcCursor..Taller ) + "'"+ [, INVENTORIG = ] + "'" + this.FormatearTextoSql( &lcCursor..INVENTORIG ) + "'"+ [, INVENTDEST = ] + "'" + this.FormatearTextoSql( &lcCursor..INVENTDEST ) + "'" + [ Where CODIGO = ] + "'" + this.FormatearTextoSql( lcValorABuscar ) + "'" )
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
					else
						this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
					endIf
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir porque no coincide la clave principal.', tlLoguear )
				endIf
			else
				this.oConexion.EjecutarSql( [Select * From ZooLogic.GESTIONPROD Where CODIGO = ] + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'", 'curSeek', this.datasessionid )
				if reccount( 'curSeek' ) > 0
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no se pudo recibir como alta porque la clave principal ya existe', tlLoguear )
				Else
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					Text to lcCampos noShow
						 FECTRANS, FALTAFW, FMODIFW, FECIMPO, FECEXPO, HALTAFW, HORAEXPO, HMODIFW, VMODIFW, ZADSFW, VALTAFW, UALTAFW, UMODIFW, SALTAFW, SMODIFW, HORAIMPO, BDMODIFW, ESTTRANS, BDALTAFW, Modelo, CODIGO, Obs, Numero, FFCH, OrdenDePro, Proceso, Taller, INVENTORIG, INVENTDEST
					EndText
					local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FALTAFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Modelo ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CODIGO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..Obs ) + "'" + ',' + transform( &lcCursor..Numero ) + ',' + "'" + this.ConvertirDateSql( &lcCursor..FFCH ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..OrdenDePro ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Proceso ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Taller ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..INVENTORIG ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..INVENTDEST ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

					this.oConexion.EjecutarSql( [Insert into ZooLogic.GESTIONPROD ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
				EndIf
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'GESTIONDEPRODUCCION'
		if This.ActualizaEnRecepcion()
		Local lcIn as String, lcCantRegistros as Integer
		Select( lcCursor )
		Count to lcCantRegistros
		If lcCantRegistros > 0
			lcIn = This.ObtenerInSqlServer( lcCursor, 'CODIGO','C')
			lnFragmento = goRegistry.nucleo.cantidadDeElementosEnSentenciaInSQL
			loIn = this.ObtenerColeccionInSqlServer( lcCursor,'','CODIGO')
			llEjecutaEnTransaccion = loIn.count > 0
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'BEGIN TRANSACTION' )
			endif
			for i = 1 to loIn.count step lnFragmento
				lcIn = this.ObtenerFragmentoColeccionInSqlServer( loIn, i, lnFragmento )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.GESTORDPRO Where CodGestPro] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.GESPCURV Where GesProdCur] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.GESPDESC Where GesProdDes] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.GESPINS Where GesProdIns] + lcIn  )
			this.oConexion.EjecutarSql( [Delete From ZooLogic.GESPIND Where GesProdInD] + lcIn  )
			endfor
			if llEjecutaEnTransaccion
				this.oConexion.EjecutarSQL( 'COMMIT TRANSACTION' )
			endif
		EndIf
	endif
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMGESTIONPROCESO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where CodGestPro in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"NROITEM","CodGestPro","Codigo","cProcDet","Orden","Taller","InvEnt","InvSal"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.GESTORDPRO ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodGestPro ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Codigo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cProcDet   ) + "'" + ',' + transform( cDetallesExistentes.Orden      ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Taller     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.InvEnt     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.InvSal     ) + "'" + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMGESTIONCURVA'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where GesProdCur in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"IdItem","NROITEM","COMP","GesProdCur","MARTDF","DESCRIPDF","cColor","cColDet","cTalle","cTalleDet","Insumo","InsumoDet","CodColor","FCOLTXT","CodTalle","TalleDet","Partida","CantProd","CantDesc"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.GESPCURV ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + transform( cDetallesExistentes.COMP       ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.GesProdCur ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.MARTDF     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DESCRIPDF  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cColor     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cColDet    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cTalle     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cTalleDet  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Insumo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.InsumoDet  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodColor   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOLTXT    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodTalle   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.TalleDet   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Partida    ) + "'" + ',' + transform( cDetallesExistentes.CantProd   ) + ',' + transform( cDetallesExistentes.CantDesc   ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMGESTIONDESCARTE'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where GesProdDes in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"IdItem","COMP","NROITEM","GesProdDes","MARTDF","DESCRIPDF","cColor","cColDet","cTalle","cTalleDet","Insumo","InsumoDet","CodColor","FCOLTXT","CodTalle","ITalleTxt","Partida","MotDesc","MotDescDet","InventDest","InventDDet","CantDesc"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.GESPDESC ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.GesProdDes ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.MARTDF     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DESCRIPDF  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cColor     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cColDet    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cTalle     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cTalleDet  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Insumo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.InsumoDet  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodColor   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOLTXT    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodTalle   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ITalleTxt  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Partida    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.MotDesc    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.MotDescDet ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.InventDest ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.InventDDet ) + "'" + ',' + transform( cDetallesExistentes.CantDesc   ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMGESTIONINSUMO'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where GesProdIns in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"CantUnit","IdItem","COMP","NROITEM","GesProdIns","MARTDF","DESCRIPDF","cColor","cColDet","cTalle","cTalleDet","Insumo","cInsDet","CodColor","FCOLTXT","CodTalle","ITalleTxt","Partida","Cantidad"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.GESPINS ( ] + lcCamposInsert + [ ) values ( ] +  transform( cDetallesExistentes.CantUnit   ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.GesProdIns ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.MARTDF     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DESCRIPDF  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cColor     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cColDet    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cTalle     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cTalleDet  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Insumo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cInsDet    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodColor   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOLTXT    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodTalle   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ITalleTxt  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Partida    ) + "'" + ',' + transform( cDetallesExistentes.Cantidad   ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	lcDetalle = This.oEntidad.cPrefijoRecibir + 'ITEMGESTIONINSDESC'
	Select * From &lcDetalle into cursor cDetallesExistentes ;
		where GesProdInD in ( select CODIGO from &lcCursor )
	select cDetallesExistentes
	Scan All
		Text to lcCamposInsert noShow
			"IdItem","COMP","NROITEM","GesProdInD","MARTDF","DESCRIPDF","cColor","cColDet","cTalle","cTalleDet","Insumo","cInsDet","CodColor","FCOLTXT","CodTalle","ITalleTxt","Partida","Cantidad"
		endText
		this.oConexion.EjecutarSql( [Insert into ZooLogic.GESPIND ( ] + lcCamposInsert + [ ) values ( ] +  "'" + this.FormatearTextoSql( cDetallesExistentes.IdItem     ) + "'" + ',' + transform( cDetallesExistentes.COMP       ) + ',' + transform( cDetallesExistentes.NROITEM    ) + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.GesProdInD ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.MARTDF     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.DESCRIPDF  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cColor     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cColDet    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cTalle     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cTalleDet  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Insumo     ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.cInsDet    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodColor   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.FCOLTXT    ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.CodTalle   ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.ITalleTxt  ) + "'" + ',' + "'" + this.FormatearTextoSql( cDetallesExistentes.Partida    ) + "'" + ',' + transform( cDetallesExistentes.Cantidad   ) + ' )'  )
		select cDetallesExistentes
	EndScan
	Use in select( 'cDetallesExistentes' )
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CODIGO C (38) , Orden N(16), texto C(80))
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
			Case  lcAlias == lcPrefijo + 'GESTIONDEPRODUCCION'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'GESTIONDEPRODUCCION_ZADSFW'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'GESTIONDEPRODUCCION_OBS'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMGESTIONPROCESO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMGESTIONCURVA'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMGESTIONDESCARTE'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMGESTIONINSUMO'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'ITEMGESTIONINSDESC'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_GESTIONPROD')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'GESTIONDEPRODUCCION'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar ) or isnull( &lcCursor..Numero )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad GESTIONDEPRODUCCION. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'GESTIONDEPRODUCCION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CODIGO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CODIGO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
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
			lcCursor = This.oEntidad.cPrefijoRecibir + 'GESTIONDEPRODUCCION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FALTAFW   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FFCH      
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_GESTIONPROD') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_GESTIONPROD
Create Table ZooLogic.TablaTrabajo_GESTIONPROD ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fectrans" datetime  null, 
"faltafw" datetime  null, 
"fmodifw" datetime  null, 
"fecimpo" datetime  null, 
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
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdaltafw" char( 8 )  null, 
"modelo" char( 15 )  null, 
"codigo" char( 38 )  null, 
"obs" varchar(max)  null, 
"numero" numeric( 12, 0 )  null, 
"ffch" datetime  null, 
"ordendepro" char( 38 )  null, 
"proceso" char( 15 )  null, 
"taller" char( 15 )  null, 
"inventorig" char( 15 )  null, 
"inventdest" char( 15 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_GESTIONPROD' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_GESTIONPROD' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'GESTIONDEPRODUCCION'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecimpo','fecimpo')
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
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('modelo','modelo')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('obs','obs')
			.AgregarMapeo('numero','numero')
			.AgregarMapeo('ffch','ffch')
			.AgregarMapeo('ordendepro','ordendepro')
			.AgregarMapeo('proceso','proceso')
			.AgregarMapeo('taller','taller')
			.AgregarMapeo('inventorig','inventorig')
			.AgregarMapeo('inventdest','inventdest')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_GESTIONPROD'
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
				Update t Set t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.MODELO = isnull( d.MODELO, t.MODELO ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.OBS = isnull( d.OBS, t.OBS ),t.NUMERO = isnull( d.NUMERO, t.NUMERO ),t.FFCH = isnull( d.FFCH, t.FFCH ),t.ORDENDEPRO = isnull( d.ORDENDEPRO, t.ORDENDEPRO ),t.PROCESO = isnull( d.PROCESO, t.PROCESO ),t.TALLER = isnull( d.TALLER, t.TALLER ),t.INVENTORIG = isnull( d.INVENTORIG, t.INVENTORIG ),t.INVENTDEST = isnull( d.INVENTDEST, t.INVENTDEST )
					from ZooLogic.GESTIONPROD t inner join deleted d 
							 on t.CODIGO = d.CODIGO
							 and  t.Numero = d.Numero
				-- Fin Updates
				insert into ZooLogic.GESTIONPROD(Fectrans,Faltafw,Fmodifw,Fecimpo,Fecexpo,Haltafw,Horaexpo,Hmodifw,Vmodifw,Zadsfw,Valtafw,Ualtafw,Umodifw,Saltafw,Smodifw,Horaimpo,Bdmodifw,Esttrans,Bdaltafw,Modelo,Codigo,Obs,Numero,Ffch,Ordendepro,Proceso,Taller,Inventorig,Inventdest)
					Select isnull( d.FECTRANS,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FMODIFW,''),isnull( d.FECIMPO,''),isnull( d.FECEXPO,''),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.HMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UALTAFW,''),isnull( d.UMODIFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.HORAIMPO,''),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),isnull( d.BDALTAFW,''),isnull( d.MODELO,''),isnull( d.CODIGO,''),isnull( d.OBS,''),isnull( d.NUMERO,0),isnull( d.FFCH,''),isnull( d.ORDENDEPRO,''),isnull( d.PROCESO,''),isnull( d.TALLER,''),isnull( d.INVENTORIG,''),isnull( d.INVENTDEST,'')
						From deleted d left join ZooLogic.GESTIONPROD pk 
							 on d.CODIGO = pk.CODIGO
						 left join ZooLogic.GESTIONPROD cc 
							 on  d.Numero = cc.Numero
						Where pk.CODIGO Is Null 
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
					from ZooLogic.GESTIONPROD t inner join deleted d 
							on   t.Numero = d.Numero
						left join deleted h 
							 on t.CODIGO = h.CODIGO
							 where h.CODIGO is null 
				Insert into ZooLogic.Logueos ( Fecha, Nivel, Logger, Accion, BaseDeDatos, 
					EstadoDelSistema, Aplicacion, Version, 
					Serie, Usuario, NombrePc, 
					UsuarioPc, OrigenLogueo, Mensaje, Excepcion)
				select GetDate(), 'INFO', '', 'Importación <<lcEntidad>>','<<loLogueo.BaseDatos>>',
					<<loLogueo.EstadoSistema>>,'<<loLogueo.Aplicacion>>','<<loLogueo.Version>>',
					'<<loLogueo.Serie>>','<<loLogueo.Usuario>>','<<loLogueo.NombrePc>>',
					'<<loLogueo.UsuarioPc>>','<<loLogueo.OrigenLogueo>>','No se pudo importar la entidad <<lcEntidad>>: NÚMERO ' + cast( d.Numero as Varchar(12) ) + '','La clave principal a importar ya existe'
					from ZooLogic.GESTIONPROD t inner join deleted d 
							 on t.CODIGO = d.CODIGO
						left join deleted h 
							on   t.Numero = h.Numero
							where   h.Numero is null 
			End
		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_GESTORDPRO( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_GESTIONPROD_GESTORDPRO
ON ZooLogic.TablaTrabajo_GESTIONPROD_GESTORDPRO
AFTER DELETE
As
Begin
Update t Set 
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.CODGESTPRO = isnull( d.CODGESTPRO, t.CODGESTPRO ),
t.CODIGO = isnull( d.CODIGO, t.CODIGO ),
t.CPROCDET = isnull( d.CPROCDET, t.CPROCDET ),
t.ORDEN = isnull( d.ORDEN, t.ORDEN ),
t.TALLER = isnull( d.TALLER, t.TALLER ),
t.INVENT = isnull( d.INVENT, t.INVENT ),
t.INVSAL = isnull( d.INVSAL, t.INVSAL )
from ZooLogic.GESTORDPRO t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.GESTORDPRO
( 
"NROITEM",
"CODGESTPRO",
"CODIGO",
"CPROCDET",
"ORDEN",
"TALLER",
"INVENT",
"INVSAL"
 )
Select 
d.NROITEM,
d.CODGESTPRO,
d.CODIGO,
d.CPROCDET,
d.ORDEN,
d.TALLER,
d.INVENT,
d.INVSAL
From deleted d left join ZooLogic.GESTORDPRO pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_GESPCURV( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_GESTIONPROD_GESPCURV
ON ZooLogic.TablaTrabajo_GESTIONPROD_GESPCURV
AFTER DELETE
As
Begin
Update t Set 
t.IDITEM = isnull( d.IDITEM, t.IDITEM ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.COMP = isnull( d.COMP, t.COMP ),
t.GESPRODCUR = isnull( d.GESPRODCUR, t.GESPRODCUR ),
t.MARTDF = isnull( d.MARTDF, t.MARTDF ),
t.DESCRIPDF = isnull( d.DESCRIPDF, t.DESCRIPDF ),
t.CCOLOR = isnull( d.CCOLOR, t.CCOLOR ),
t.CCOLDET = isnull( d.CCOLDET, t.CCOLDET ),
t.CTALLE = isnull( d.CTALLE, t.CTALLE ),
t.CTALLEDET = isnull( d.CTALLEDET, t.CTALLEDET ),
t.INSUMO = isnull( d.INSUMO, t.INSUMO ),
t.INSUMODET = isnull( d.INSUMODET, t.INSUMODET ),
t.CODCOLOR = isnull( d.CODCOLOR, t.CODCOLOR ),
t.FCOLTXT = isnull( d.FCOLTXT, t.FCOLTXT ),
t.CODTALLE = isnull( d.CODTALLE, t.CODTALLE ),
t.TALLEDET = isnull( d.TALLEDET, t.TALLEDET ),
t.PARTIDA = isnull( d.PARTIDA, t.PARTIDA ),
t.CANTPROD = isnull( d.CANTPROD, t.CANTPROD ),
t.CANTDESC = isnull( d.CANTDESC, t.CANTDESC )
from ZooLogic.GESPCURV t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.GESPCURV
( 
"IDITEM",
"NROITEM",
"COMP",
"GESPRODCUR",
"MARTDF",
"DESCRIPDF",
"CCOLOR",
"CCOLDET",
"CTALLE",
"CTALLEDET",
"INSUMO",
"INSUMODET",
"CODCOLOR",
"FCOLTXT",
"CODTALLE",
"TALLEDET",
"PARTIDA",
"CANTPROD",
"CANTDESC"
 )
Select 
d.IDITEM,
d.NROITEM,
d.COMP,
d.GESPRODCUR,
d.MARTDF,
d.DESCRIPDF,
d.CCOLOR,
d.CCOLDET,
d.CTALLE,
d.CTALLEDET,
d.INSUMO,
d.INSUMODET,
d.CODCOLOR,
d.FCOLTXT,
d.CODTALLE,
d.TALLEDET,
d.PARTIDA,
d.CANTPROD,
d.CANTDESC
From deleted d left join ZooLogic.GESPCURV pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_GESPDESC( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_GESTIONPROD_GESPDESC
ON ZooLogic.TablaTrabajo_GESTIONPROD_GESPDESC
AFTER DELETE
As
Begin
Update t Set 
t.IDITEM = isnull( d.IDITEM, t.IDITEM ),
t.COMP = isnull( d.COMP, t.COMP ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.GESPRODDES = isnull( d.GESPRODDES, t.GESPRODDES ),
t.MARTDF = isnull( d.MARTDF, t.MARTDF ),
t.DESCRIPDF = isnull( d.DESCRIPDF, t.DESCRIPDF ),
t.CCOLOR = isnull( d.CCOLOR, t.CCOLOR ),
t.CCOLDET = isnull( d.CCOLDET, t.CCOLDET ),
t.CTALLE = isnull( d.CTALLE, t.CTALLE ),
t.CTALLEDET = isnull( d.CTALLEDET, t.CTALLEDET ),
t.INSUMO = isnull( d.INSUMO, t.INSUMO ),
t.INSUMODET = isnull( d.INSUMODET, t.INSUMODET ),
t.CODCOLOR = isnull( d.CODCOLOR, t.CODCOLOR ),
t.FCOLTXT = isnull( d.FCOLTXT, t.FCOLTXT ),
t.CODTALLE = isnull( d.CODTALLE, t.CODTALLE ),
t.ITALLETXT = isnull( d.ITALLETXT, t.ITALLETXT ),
t.PARTIDA = isnull( d.PARTIDA, t.PARTIDA ),
t.MOTDESC = isnull( d.MOTDESC, t.MOTDESC ),
t.MOTDESCDET = isnull( d.MOTDESCDET, t.MOTDESCDET ),
t.INVENTDEST = isnull( d.INVENTDEST, t.INVENTDEST ),
t.INVENTDDET = isnull( d.INVENTDDET, t.INVENTDDET ),
t.CANTDESC = isnull( d.CANTDESC, t.CANTDESC )
from ZooLogic.GESPDESC t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.GESPDESC
( 
"IDITEM",
"COMP",
"NROITEM",
"GESPRODDES",
"MARTDF",
"DESCRIPDF",
"CCOLOR",
"CCOLDET",
"CTALLE",
"CTALLEDET",
"INSUMO",
"INSUMODET",
"CODCOLOR",
"FCOLTXT",
"CODTALLE",
"ITALLETXT",
"PARTIDA",
"MOTDESC",
"MOTDESCDET",
"INVENTDEST",
"INVENTDDET",
"CANTDESC"
 )
Select 
d.IDITEM,
d.COMP,
d.NROITEM,
d.GESPRODDES,
d.MARTDF,
d.DESCRIPDF,
d.CCOLOR,
d.CCOLDET,
d.CTALLE,
d.CTALLEDET,
d.INSUMO,
d.INSUMODET,
d.CODCOLOR,
d.FCOLTXT,
d.CODTALLE,
d.ITALLETXT,
d.PARTIDA,
d.MOTDESC,
d.MOTDESCDET,
d.INVENTDEST,
d.INVENTDDET,
d.CANTDESC
From deleted d left join ZooLogic.GESPDESC pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_GESPINS( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_GESTIONPROD_GESPINS
ON ZooLogic.TablaTrabajo_GESTIONPROD_GESPINS
AFTER DELETE
As
Begin
Update t Set 
t.CANTUNIT = isnull( d.CANTUNIT, t.CANTUNIT ),
t.IDITEM = isnull( d.IDITEM, t.IDITEM ),
t.COMP = isnull( d.COMP, t.COMP ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.GESPRODINS = isnull( d.GESPRODINS, t.GESPRODINS ),
t.MARTDF = isnull( d.MARTDF, t.MARTDF ),
t.DESCRIPDF = isnull( d.DESCRIPDF, t.DESCRIPDF ),
t.CCOLOR = isnull( d.CCOLOR, t.CCOLOR ),
t.CCOLDET = isnull( d.CCOLDET, t.CCOLDET ),
t.CTALLE = isnull( d.CTALLE, t.CTALLE ),
t.CTALLEDET = isnull( d.CTALLEDET, t.CTALLEDET ),
t.INSUMO = isnull( d.INSUMO, t.INSUMO ),
t.CINSDET = isnull( d.CINSDET, t.CINSDET ),
t.CODCOLOR = isnull( d.CODCOLOR, t.CODCOLOR ),
t.FCOLTXT = isnull( d.FCOLTXT, t.FCOLTXT ),
t.CODTALLE = isnull( d.CODTALLE, t.CODTALLE ),
t.ITALLETXT = isnull( d.ITALLETXT, t.ITALLETXT ),
t.PARTIDA = isnull( d.PARTIDA, t.PARTIDA ),
t.CANTIDAD = isnull( d.CANTIDAD, t.CANTIDAD )
from ZooLogic.GESPINS t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.GESPINS
( 
"CANTUNIT",
"IDITEM",
"COMP",
"NROITEM",
"GESPRODINS",
"MARTDF",
"DESCRIPDF",
"CCOLOR",
"CCOLDET",
"CTALLE",
"CTALLEDET",
"INSUMO",
"CINSDET",
"CODCOLOR",
"FCOLTXT",
"CODTALLE",
"ITALLETXT",
"PARTIDA",
"CANTIDAD"
 )
Select 
d.CANTUNIT,
d.IDITEM,
d.COMP,
d.NROITEM,
d.GESPRODINS,
d.MARTDF,
d.DESCRIPDF,
d.CCOLOR,
d.CCOLDET,
d.CTALLE,
d.CTALLEDET,
d.INSUMO,
d.CINSDET,
d.CODCOLOR,
d.FCOLTXT,
d.CODTALLE,
d.ITALLETXT,
d.PARTIDA,
d.CANTIDAD
From deleted d left join ZooLogic.GESPINS pk 
 on d.CODIGO = pk.CODIGO
Where pk.CODIGO Is Null 
-- Fin Inserts
End

		EndText
		Return lcCadena
	endfunc

*--------------------------------------------------------------------------------------------------------
	function ObtenerTriggerDeleteImportacion_GESPIND( tcTablaTrabajo ) as String

		Text to lcCadena noshow textmerge
		CREATE TRIGGER ZooLogic.DELETE_TablaTrabajo_GESTIONPROD_GESPIND
ON ZooLogic.TablaTrabajo_GESTIONPROD_GESPIND
AFTER DELETE
As
Begin
Update t Set 
t.IDITEM = isnull( d.IDITEM, t.IDITEM ),
t.COMP = isnull( d.COMP, t.COMP ),
t.NROITEM = isnull( d.NROITEM, t.NROITEM ),
t.GESPRODIND = isnull( d.GESPRODIND, t.GESPRODIND ),
t.MARTDF = isnull( d.MARTDF, t.MARTDF ),
t.DESCRIPDF = isnull( d.DESCRIPDF, t.DESCRIPDF ),
t.CCOLOR = isnull( d.CCOLOR, t.CCOLOR ),
t.CCOLDET = isnull( d.CCOLDET, t.CCOLDET ),
t.CTALLE = isnull( d.CTALLE, t.CTALLE ),
t.CTALLEDET = isnull( d.CTALLEDET, t.CTALLEDET ),
t.INSUMO = isnull( d.INSUMO, t.INSUMO ),
t.CINSDET = isnull( d.CINSDET, t.CINSDET ),
t.CODCOLOR = isnull( d.CODCOLOR, t.CODCOLOR ),
t.FCOLTXT = isnull( d.FCOLTXT, t.FCOLTXT ),
t.CODTALLE = isnull( d.CODTALLE, t.CODTALLE ),
t.ITALLETXT = isnull( d.ITALLETXT, t.ITALLETXT ),
t.PARTIDA = isnull( d.PARTIDA, t.PARTIDA ),
t.CANTIDAD = isnull( d.CANTIDAD, t.CANTIDAD )
from ZooLogic.GESPIND t inner join deleted d 
 on t.CODIGO = d.CODIGO
-- Fin Updates
insert into ZooLogic.GESPIND
( 
"IDITEM",
"COMP",
"NROITEM",
"GESPRODIND",
"MARTDF",
"DESCRIPDF",
"CCOLOR",
"CCOLDET",
"CTALLE",
"CTALLEDET",
"INSUMO",
"CINSDET",
"CODCOLOR",
"FCOLTXT",
"CODTALLE",
"ITALLETXT",
"PARTIDA",
"CANTIDAD"
 )
Select 
d.IDITEM,
d.COMP,
d.NROITEM,
d.GESPRODIND,
d.MARTDF,
d.DESCRIPDF,
d.CCOLOR,
d.CCOLDET,
d.CTALLE,
d.CTALLEDET,
d.INSUMO,
d.CINSDET,
d.CODCOLOR,
d.FCOLTXT,
d.CODTALLE,
d.ITALLETXT,
d.PARTIDA,
d.CANTIDAD
From deleted d left join ZooLogic.GESPIND pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_GESTIONPROD') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_GESTIONPROD
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_GESTIONDEPRODUCCION' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_GESTIONDEPRODUCCION.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_GESTIONDEPRODUCCION.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_GESTIONDEPRODUCCION.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_GESTIONDEPRODUCCION.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_GESTIONDEPRODUCCION.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Horaaltafw = nvl( c_GESTIONDEPRODUCCION.Horaaltafw, [] )
					.Horaexpo = nvl( c_GESTIONDEPRODUCCION.Horaexpo, [] )
					.Horamodificacionfw = nvl( c_GESTIONDEPRODUCCION.Horamodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_GESTIONDEPRODUCCION.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_GESTIONDEPRODUCCION.Versionaltafw, [] )
					.Usuarioaltafw = nvl( c_GESTIONDEPRODUCCION.Usuarioaltafw, [] )
					.Usuariomodificacionfw = nvl( c_GESTIONDEPRODUCCION.Usuariomodificacionfw, [] )
					.Seriealtafw = nvl( c_GESTIONDEPRODUCCION.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_GESTIONDEPRODUCCION.Seriemodificacionfw, [] )
					.Horaimpo = nvl( c_GESTIONDEPRODUCCION.Horaimpo, [] )
					.Basededatosmodificacionfw = nvl( c_GESTIONDEPRODUCCION.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_GESTIONDEPRODUCCION.Estadotransferencia, [] )
					.Basededatosaltafw = nvl( c_GESTIONDEPRODUCCION.Basededatosaltafw, [] )
					.Modelo_PK =  nvl( c_GESTIONDEPRODUCCION.Modelo, [] )
					.Codigo = nvl( c_GESTIONDEPRODUCCION.Codigo, [] )
					lcValor = This.ObtenerMemo( 'c_Obs')
					.Obs = lcValor 
					.Procesos.Limpiar()
					.Procesos.SetearEsNavegacion( .lProcesando )
					.Procesos.Cargar()
					.Numero = nvl( c_GESTIONDEPRODUCCION.Numero, 0 )
					.Gestioncurva.Limpiar()
					.Gestioncurva.SetearEsNavegacion( .lProcesando )
					.Gestioncurva.Cargar()
					.Gestiondescartes.Limpiar()
					.Gestiondescartes.SetearEsNavegacion( .lProcesando )
					.Gestiondescartes.Cargar()
					.Fecha = GoLibrerias.ObtenerFechaFormateada( nvl( c_GESTIONDEPRODUCCION.Fecha, ctod( '  /  /    ' ) ) )
					.Gestioninsumos.Limpiar()
					.Gestioninsumos.SetearEsNavegacion( .lProcesando )
					.Gestioninsumos.Cargar()
					.Gestioninsumosdescartes.Limpiar()
					.Gestioninsumosdescartes.SetearEsNavegacion( .lProcesando )
					.Gestioninsumosdescartes.Cargar()
					.Ordendeproduccion_PK =  nvl( c_GESTIONDEPRODUCCION.Ordendeproduccion, [] )
					.Proceso_PK =  nvl( c_GESTIONDEPRODUCCION.Proceso, [] )
					.Taller_PK =  nvl( c_GESTIONDEPRODUCCION.Taller, [] )
					.Inventarioorigen_PK =  nvl( c_GESTIONDEPRODUCCION.Inventarioorigen, [] )
					.Inventariodestino_PK =  nvl( c_GESTIONDEPRODUCCION.Inventariodestino, [] )
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
			lxRetorno = c_GESTIONDEPRODUCCION.CODIGO
		endif
		return lxRetorno
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

		loDetalle = this.oEntidad.GestionCurva
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

		loDetalle = this.oEntidad.GestionDescartes
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

		loDetalle = this.oEntidad.GestionInsumos
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

		loDetalle = this.oEntidad.GestionInsumosDescartes
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
		return c_GESTIONDEPRODUCCION.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.GESTIONPROD' )
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
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CODIGO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
		text to lcSQL textmerge noshow
				SELECT nro,totalRegistros,CODIGO as Id
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    CODIGO from (
							select * 
								from ZooLogic.GESTIONPROD 
								Where   GESTIONPROD.CODIGO != ''
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "GESTIONPROD", "", lcCursor, set("Datasession") )
		lcXml = this.CursorAXml( lcCursor )
		
		use in select( lcCursor )
		
		Return lcXml 
		
	endfunc
	*-----------------------------------------------------------------------------------------
	function ObtenerDatosEntidadPaginado( tcOrderBy as String, tcFiltro as String, tnCantidad as Integer, tnPagina as Integer )  as String
		local lcOrderBy as String, lnCuantos as Integer, lnPagina as Integer, lnTope as Integer, lnDesde as Integer, lcSQL as String, lcCursor as String, lcXml as String
		lcOrderBy = iif( !empty( tcOrderBy ), tcOrderBy + ",", "" ) + "CODIGO"
		
		lnCuantos = tnCantidad
		lnPagina = tnPagina
		lnTope = lnCuantos  * lnPagina 
		lnDesde = lnCuantos  * ( lnPagina - 1 ) + 1
		
			text to lcAtributos textmerge noshow
			"Fectrans" as "Fechatransferencia", "Faltafw" as "Fechaaltafw", "Fmodifw" as "Fechamodificacionfw", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Ualtafw" as "Usuarioaltafw", "Umodifw" as "Usuariomodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Horaimpo" as "Horaimpo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Bdaltafw" as "Basededatosaltafw", "Modelo" as "Modelo", "Codigo" as "Codigo", "Obs" as "Obs", "Numero" as "Numero", "Ffch" as "Fecha", "Ordendepro" as "Ordendeproduccion", "Proceso" as "Proceso", "Taller" as "Taller", "Inventorig" as "Inventarioorigen", "Inventdest" as "Inventariodestino"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.GESTIONPROD 
								Where   GESTIONPROD.CODIGO != ''
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
	Tabla = 'GESTIONPROD'
	Filtro = " GESTIONPROD.CODIGO != ''"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " GESTIONPROD.CODIGO != ''"
	AnchoCampo = 13
	Caracteres = 13
	nrodecolumnas = 0
	signopregunta = .T.
	signopregunta2 = .t.
	TablaAuxiliar = .f.
	cOrden = "GESTIONPROD.Numero"
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
	<row entidad="GESTIONDEPRODUCCION                     " atributo="FECHATRANSFERENCIA                      " tabla="GESTIONPROD    " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                                                                                                          " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="FECHAALTAFW                             " tabla="GESTIONPROD    " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha alta                                                                                                                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="FECHAMODIFICACIONFW                     " tabla="GESTIONPROD    " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                                                                                                                        " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="FECHAIMPO                               " tabla="GESTIONPROD    " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="FECHAEXPO                               " tabla="GESTIONPROD    " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                                                                                                                         " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="HORAALTAFW                              " tabla="GESTIONPROD    " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                                                                                                                 " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="HORAEXPO                                " tabla="GESTIONPROD    " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="HORAMODIFICACIONFW                      " tabla="GESTIONPROD    " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="VERSIONMODIFICACIONFW                   " tabla="GESTIONPROD    " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="ZADSFW                                  " tabla="GESTIONPROD    " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="VERSIONALTAFW                           " tabla="GESTIONPROD    " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="USUARIOALTAFW                           " tabla="GESTIONPROD    " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="USUARIOMODIFICACIONFW                   " tabla="GESTIONPROD    " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="SERIEALTAFW                             " tabla="GESTIONPROD    " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="SERIEMODIFICACIONFW                     " tabla="GESTIONPROD    " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="HORAIMPO                                " tabla="GESTIONPROD    " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                                                                                                          " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="GESTIONPROD    " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="ESTADOTRANSFERENCIA                     " tabla="GESTIONPROD    " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                                                                                                                         " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="BASEDEDATOSALTAFW                       " tabla="GESTIONPROD    " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                                                                                                                        " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="MODELO                                  " tabla="GESTIONPROD    " campo="MODELO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MODELODEPRODUCCION                      " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Modelo                                                                                                                                                                                                                                                    " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="CODIGO                                  " tabla="GESTIONPROD    " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Código                                                                                                                                                                                                                                                    " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="OBS                                     " tabla="GESTIONPROD    " campo="OBS       " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="400" etiqueta="Observaciones                                                                                                                                                                                                                                             " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="PROCESOS                                " tabla="GESTORDPRO     " campo="CODGESTPRO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Procesos                                                                                                                                                                                                                                                  " dominio="DETALLEITEMGESTIONPROCESO     " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="NUMERO                                  " tabla="GESTIONPROD    " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="2" etiqueta="Nro. gestión de producción                                                                                                                                                                                                                                " dominio="CLAVECANDIDATA                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="1" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="GESTIONCURVA                            " tabla="GESPCURV       " campo="GESPRODCUR" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Detalle                                                                                                                                                                                                                                                   " dominio="DETALLEITEMGESTIONCURVA       " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="GESTIONDESCARTES                        " tabla="GESPDESC       " campo="GESPRODDES" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Descarte                                                                                                                                                                                                                                                  " dominio="DETALLEITEMGESTIONDESCARTE    " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="1" orden="1" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="FECHA                                   " tabla="GESTIONPROD    " campo="FFCH      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=goServicios.librerias.ObtenerFecha()                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="10" etiqueta="Fecha                                                                                                                                                                                                                                                     " dominio="FECHACOMPROBANTE              " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="GESTIONINSUMOS                          " tabla="GESPINS        " campo="GESPRODINS" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="406" etiqueta="Insumos                                                                                                                                                                                                                                                   " dominio="DETALLEITEMGESTIONINSUMO      " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="1" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="GESTIONINSUMOSDESCARTES                 " tabla="GESPIND        " campo="GESPRODIND" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Insumos descarte                                                                                                                                                                                                                                          " dominio="DETALLEITEMGESTIONINSDESC     " detalle="true" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="2" subgrupo="2" orden="2" alta="true" incluiratrib="false" excluiratrib="true" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="ORDENDEPRODUCCION                       " tabla="GESTIONPROD    " campo="ORDENDEPRO" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ORDENDEPRODUCCION                       " tipodato="C         " longitud="38" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="20" etiqueta="Orden de producción                                                                                                                                                                                                                                       " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="NUMERODEORDEN                           " tabla="ORDENPROD      " campo="NUMERO    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="12" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="6" etiqueta="Número de orden                                                                                                                                                                                                                                           " dominio="NUMERICONONEGATIVO            " detalle="false" tipo="E" atributoforaneo="OrdenDeProduccion.Numero                                                                                                                                                                                                                                      " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" left join ORDENPROD on GESTIONPROD.ORDENDEPRO = ORDENPROD.Codigo                                                                                                                                                                                             " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="4" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="PROCESO                                 " tabla="GESTIONPROD    " campo="PROCESO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROCESOPRODUCCION                       " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="8" etiqueta="Proceso                                                                                                                                                                                                                                                   " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="TALLER                                  " tabla="GESTIONPROD    " campo="TALLER    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLER                                  " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="16" etiqueta="Taller                                                                                                                                                                                                                                                    " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="INVENTARIOORIGEN                        " tabla="GESTIONPROD    " campo="INVENTORIG" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="INVENTARIO                              " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="12" etiqueta="Inventario insumos                                                                                                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GESTIONDEPRODUCCION                     " atributo="INVENTARIODESTINO                       " tabla="GESTIONPROD    " campo="INVENTDEST" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="INVENTARIO                              " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="true" admitebusqueda="14" etiqueta="Inventario salidas                                                                                                                                                                                                                                        " dominio="CODIGO                        " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ORDENDEPRODUCCION                       " atributo="DESCRIPCION                             " tabla="ORDENPROD      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="21" etiqueta="Detalle Ord.                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ORDENPROD On GESTIONPROD.ORDENDEPRO = ORDENPROD.Codigo And  ORDENPROD.CODIGO != ''                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROCESOPRODUCCION                       " atributo="DESCRIPCION                             " tabla="PROCPRODUC     " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="250" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="9" etiqueta="Detalle Pro.                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROCPRODUC On GESTIONPROD.PROCESO = PROCPRODUC.Codigo And  PROCPRODUC.CODIGO != ''                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLER                                  " atributo="DESCRIPCION                             " tabla="TALLER         " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="17" etiqueta="Detalle Tal.                                                                                                                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TALLER On GESTIONPROD.TALLER = TALLER.Codigo And  TALLER.CODIGO != ''                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INVENTARIO                              " atributo="DESCRIPCION                             " tabla="INV            " campo="INVDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="13" etiqueta="Detalle Inv.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join INV On GESTIONPROD.INVENTORIG = INV.invcod And  INV.INVCOD != ''                                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="INVENTARIO                              " atributo="DESCRIPCION                             " tabla="INV            " campo="INVDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="15" etiqueta="Detalle Inv.                                                                                                                                                                                                                                              " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join INV On GESTIONPROD.INVENTDEST = INV.invcod And  INV.INVCOD != ''                                                                                                                                                                                   " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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