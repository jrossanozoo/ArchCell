
define class Din_EntidadTIINVENTARIOACONTAD_SQLServer as AccesoDatosEntidad_SqlServer of AccesoDatosEntidad_SqlServer.prg

	cNombreCursor = 'c_TIINVENTARIOACONT'
	colSentencias = null
	cArchivoLogPrueba = '' 
	cRutaTablas = ''
	nReintentos = 3
	oCol = 3
	cExpresionCCPorAtributos = []
	cExpresionCCPorCampos = []
	cTagClaveCandidata = ''
	cTagClavePk = '_TITPK'
	cTablaPrincipal = 'TIINVCONT'
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
			local  lxTiinvcontFectrans, lxTiinvcontFecimpo, lxTiinvcontFmodifw, lxTiinvcontFecexpo, lxTiinvcontCodigo, lxTiinvcontBdmodifw, lxTiinvcontEsttrans, lxTiinvcontHaltafw, lxTiinvcontHoraexpo, lxTiinvcontBdaltafw, lxTiinvcontHoraimpo, lxTiinvcontVmodifw, lxTiinvcontZadsfw, lxTiinvcontValtafw, lxTiinvcontUmodifw, lxTiinvcontHmodifw, lxTiinvcontSaltafw, lxTiinvcontSmodifw, lxTiinvcontUaltafw, lxTiinvcontDescrip, lxTiinvcontFaltafw, lxTiinvcontFechad, lxTiinvcontFechah, lxTiinvcontArtdesde, lxTiinvcontArthasta, lxTiinvcontColdesde, lxTiinvcontColhasta, lxTiinvcontTaldesde, lxTiinvcontTalhasta, lxTiinvcontProvdesde, lxTiinvcontProvhasta, lxTiinvcontUnmeddesde, lxTiinvcontUnmedhasta, lxTiinvcontMatdesde, lxTiinvcontMathasta, lxTiinvcontMobs
				lxTiinvcontFectrans =  .Fechatransferencia			lxTiinvcontFecimpo =  .Fechaimpo			lxTiinvcontFmodifw =  .Fechamodificacionfw			lxTiinvcontFecexpo =  .Fechaexpo			lxTiinvcontCodigo =  .Codigo			lxTiinvcontBdmodifw =  .Basededatosmodificacionfw			lxTiinvcontEsttrans =  .Estadotransferencia			lxTiinvcontHaltafw =  .Horaaltafw			lxTiinvcontHoraexpo =  .Horaexpo			lxTiinvcontBdaltafw =  .Basededatosaltafw			lxTiinvcontHoraimpo =  .Horaimpo			lxTiinvcontVmodifw =  .Versionmodificacionfw			lxTiinvcontZadsfw =  .Zadsfw			lxTiinvcontValtafw =  .Versionaltafw			lxTiinvcontUmodifw =  .Usuariomodificacionfw			lxTiinvcontHmodifw =  .Horamodificacionfw			lxTiinvcontSaltafw =  .Seriealtafw			lxTiinvcontSmodifw =  .Seriemodificacionfw			lxTiinvcontUaltafw =  .Usuarioaltafw			lxTiinvcontDescrip =  .Descripcion			lxTiinvcontFaltafw =  .Fechaaltafw			lxTiinvcontFechad =  .Fechadesde			lxTiinvcontFechah =  .Fechahasta			lxTiinvcontArtdesde =  .Articulodesde			lxTiinvcontArthasta =  .Articulohasta			lxTiinvcontColdesde =  .Colordesde			lxTiinvcontColhasta =  .Colorhasta			lxTiinvcontTaldesde =  .Talledesde			lxTiinvcontTalhasta =  .Tallehasta			lxTiinvcontProvdesde =  .Proveedordesde			lxTiinvcontProvhasta =  .Proveedorhasta			lxTiinvcontUnmeddesde =  .Unidaddemedidadesde			lxTiinvcontUnmedhasta =  .Unidaddemedidahasta			lxTiinvcontMatdesde =  .Materialdesde			lxTiinvcontMathasta =  .Materialhasta			lxTiinvcontMobs =  .Obs
		endwith
		
		for lnI = 1 to 3
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()

			lxTiinvcontCodigo = this.VerificarUnicidad()

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				insert into ZooLogic.TIINVCONT ( "Fectrans","Fecimpo","Fmodifw","Fecexpo","Codigo","Bdmodifw","Esttrans","Haltafw","Horaexpo","Bdaltafw","Horaimpo","Vmodifw","Zadsfw","Valtafw","Umodifw","Hmodifw","Saltafw","Smodifw","Ualtafw","Descrip","Faltafw","Fechad","Fechah","Artdesde","Arthasta","Coldesde","Colhasta","Taldesde","Talhasta","Provdesde","Provhasta","Unmeddesde","Unmedhasta","Matdesde","Mathasta","Mobs" ) values ( <<"'" + this.ConvertirDateSql( lxTiinvcontFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvcontFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvcontFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvcontFecexpo ) + "'" >>, <<lxTiinvcontCodigo >>, <<"'" + this.FormatearTextoSql( lxTiinvcontBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontDescrip ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvcontFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvcontFechad ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvcontFechah ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontArtdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontArthasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontColdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontColhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontTaldesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontTalhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontProvdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontProvhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontUnmeddesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontUnmedhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontMatdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontMathasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontMobs ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria

			dodefault()
			local lxArticuloDesde, lxArticuloHasta, lxColorDesde, lxColorHasta, lxTalleDesde, lxTalleHasta, lxFechaHasta, lxFechaAltaFW, lxCodigo, lxProveedorDesde, lxProveedorHasta, lxUnidadDeMedidaDesde, lxUnidadDeMedidaHasta, lxMaterialDesde, lxMaterialHasta
			if empty( this.oEntidad.ArticuloDesde )
				lxArticuloDesde = null
			else
				lxArticuloDesde = this.oEntidad.ArticuloDesde
			endif
			if this.oEntidad.ArticuloHasta = [ZZZZZZZZZZZZZ]
				lxArticuloHasta = null
			else
				lxArticuloHasta = this.oEntidad.ArticuloHasta
			endif
			if empty( this.oEntidad.ColorDesde )
				lxColorDesde = null
			else
				lxColorDesde = this.oEntidad.ColorDesde
			endif
			if this.oEntidad.ColorHasta = [ZZ]
				lxColorHasta = null
			else
				lxColorHasta = this.oEntidad.ColorHasta
			endif
			if empty( this.oEntidad.TalleDesde )
				lxTalleDesde = null
			else
				lxTalleDesde = this.oEntidad.TalleDesde
			endif
			if this.oEntidad.TalleHasta = [ZZZ]
				lxTalleHasta = null
			else
				lxTalleHasta = this.oEntidad.TalleHasta
			endif
			lxFechaHasta = this.oEntidad.FechaHasta
			lxFechaAltaFW = this.oEntidad.FechaAltaFW
			if empty( this.oEntidad.Codigo )
				lxCodigo = null
			else
				lxCodigo = this.oEntidad.Codigo
			endif
			if empty( this.oEntidad.ProveedorDesde )
				lxProveedorDesde = null
			else
				lxProveedorDesde = this.oEntidad.ProveedorDesde
			endif
			if this.oEntidad.ProveedorHasta = [ZZZZZ]
				lxProveedorHasta = null
			else
				lxProveedorHasta = this.oEntidad.ProveedorHasta
			endif
			if empty( this.oEntidad.UnidadDeMedidaDesde )
				lxUnidadDeMedidaDesde = null
			else
				lxUnidadDeMedidaDesde = this.oEntidad.UnidadDeMedidaDesde
			endif
			if this.oEntidad.UnidadDeMedidaHasta = [ZZZ]
				lxUnidadDeMedidaHasta = null
			else
				lxUnidadDeMedidaHasta = this.oEntidad.UnidadDeMedidaHasta
			endif
			if empty( this.oEntidad.MaterialDesde )
				lxMaterialDesde = null
			else
				lxMaterialDesde = this.oEntidad.MaterialDesde
			endif
			if this.oEntidad.MaterialHasta = [ZZZZZZZZZZ]
				lxMaterialHasta = null
			else
				lxMaterialHasta = this.oEntidad.MaterialHasta
			endif
			this.oSP.InsertarDesdeOtraEntidad(lxArticuloDesde, lxArticuloHasta, lxColorDesde, lxColorHasta, lxTalleDesde, lxTalleHasta, lxFechaHasta, lxFechaAltaFW, lxCodigo, lxProveedorDesde, lxProveedorHasta, lxUnidadDeMedidaDesde, lxUnidadDeMedidaHasta, lxMaterialDesde, lxMaterialHasta)
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
		return this.oEntidad.CODIGO
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function Actualizar() as boolean
	local loError as Exception, loEx as Exception, lxValorClavePrimaria as variant, lnI as Integer, loSentenciasTriggers as zoocoleccion OF zoocoleccion.prg, lcSentencia as string

		with this.oEntidad
			local  lxTiinvcontFectrans, lxTiinvcontFecimpo, lxTiinvcontFmodifw, lxTiinvcontFecexpo, lxTiinvcontCodigo, lxTiinvcontBdmodifw, lxTiinvcontEsttrans, lxTiinvcontHaltafw, lxTiinvcontHoraexpo, lxTiinvcontBdaltafw, lxTiinvcontHoraimpo, lxTiinvcontVmodifw, lxTiinvcontZadsfw, lxTiinvcontValtafw, lxTiinvcontUmodifw, lxTiinvcontHmodifw, lxTiinvcontSaltafw, lxTiinvcontSmodifw, lxTiinvcontUaltafw, lxTiinvcontDescrip, lxTiinvcontFaltafw, lxTiinvcontFechad, lxTiinvcontFechah, lxTiinvcontArtdesde, lxTiinvcontArthasta, lxTiinvcontColdesde, lxTiinvcontColhasta, lxTiinvcontTaldesde, lxTiinvcontTalhasta, lxTiinvcontProvdesde, lxTiinvcontProvhasta, lxTiinvcontUnmeddesde, lxTiinvcontUnmedhasta, lxTiinvcontMatdesde, lxTiinvcontMathasta, lxTiinvcontMobs
				lxTiinvcontFectrans =  .Fechatransferencia			lxTiinvcontFecimpo =  .Fechaimpo			lxTiinvcontFmodifw =  .Fechamodificacionfw			lxTiinvcontFecexpo =  .Fechaexpo			lxTiinvcontCodigo =  .Codigo			lxTiinvcontBdmodifw =  .Basededatosmodificacionfw			lxTiinvcontEsttrans =  .Estadotransferencia			lxTiinvcontHaltafw =  .Horaaltafw			lxTiinvcontHoraexpo =  .Horaexpo			lxTiinvcontBdaltafw =  .Basededatosaltafw			lxTiinvcontHoraimpo =  .Horaimpo			lxTiinvcontVmodifw =  .Versionmodificacionfw			lxTiinvcontZadsfw =  .Zadsfw			lxTiinvcontValtafw =  .Versionaltafw			lxTiinvcontUmodifw =  .Usuariomodificacionfw			lxTiinvcontHmodifw =  .Horamodificacionfw			lxTiinvcontSaltafw =  .Seriealtafw			lxTiinvcontSmodifw =  .Seriemodificacionfw			lxTiinvcontUaltafw =  .Usuarioaltafw			lxTiinvcontDescrip =  .Descripcion			lxTiinvcontFaltafw =  .Fechaaltafw			lxTiinvcontFechad =  .Fechadesde			lxTiinvcontFechah =  .Fechahasta			lxTiinvcontArtdesde =  .Articulodesde			lxTiinvcontArthasta =  .Articulohasta			lxTiinvcontColdesde =  .Colordesde			lxTiinvcontColhasta =  .Colorhasta			lxTiinvcontTaldesde =  .Talledesde			lxTiinvcontTalhasta =  .Tallehasta			lxTiinvcontProvdesde =  .Proveedordesde			lxTiinvcontProvhasta =  .Proveedorhasta			lxTiinvcontUnmeddesde =  .Unidaddemedidadesde			lxTiinvcontUnmedhasta =  .Unidaddemedidahasta			lxTiinvcontMatdesde =  .Materialdesde			lxTiinvcontMathasta =  .Materialhasta			lxTiinvcontMobs =  .Obs
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.TIINVCONT set "Fectrans" = <<"'" + this.ConvertirDateSql( lxTiinvcontFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxTiinvcontFecimpo ) + "'">>,"Fmodifw" = <<"'" + this.ConvertirDateSql( lxTiinvcontFmodifw ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxTiinvcontFecexpo ) + "'">>,"Codigo" = <<lxTiinvcontCodigo>>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxTiinvcontBdmodifw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxTiinvcontEsttrans ) + "'">>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxTiinvcontHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxTiinvcontHoraexpo ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxTiinvcontBdaltafw ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxTiinvcontHoraimpo ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxTiinvcontVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxTiinvcontZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxTiinvcontValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxTiinvcontUmodifw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxTiinvcontHmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxTiinvcontSaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxTiinvcontSmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxTiinvcontUaltafw ) + "'">>,"Descrip" = <<"'" + this.FormatearTextoSql( lxTiinvcontDescrip ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxTiinvcontFaltafw ) + "'">>,"Fechad" = <<"'" + this.ConvertirDateSql( lxTiinvcontFechad ) + "'">>,"Fechah" = <<"'" + this.ConvertirDateSql( lxTiinvcontFechah ) + "'">>,"Artdesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontArtdesde ) + "'">>,"Arthasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontArthasta ) + "'">>,"Coldesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontColdesde ) + "'">>,"Colhasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontColhasta ) + "'">>,"Taldesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontTaldesde ) + "'">>,"Talhasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontTalhasta ) + "'">>,"Provdesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontProvdesde ) + "'">>,"Provhasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontProvhasta ) + "'">>,"Unmeddesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontUnmeddesde ) + "'">>,"Unmedhasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontUnmedhasta ) + "'">>,"Matdesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontMatdesde ) + "'">>,"Mathasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontMathasta ) + "'">>,"Mobs" = <<"'" + this.FormatearTextoSql( lxTiinvcontMobs ) + "'">> where "Codigo" = <<lxTiinvcontCodigo>> and  TIINVCONT.CODIGO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
			this.ComprobarResultadoDeEjecucionDelUpdate()
		this.ComprobarTransaccion()
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
			 lcXml = this.oConexion.EjecutarSql( "select Top 1 CODIGO from ZooLogic.TIINVCONT where " + this.ConvertirFuncionesSql( " TIINVCONT.CODIGO != 0" ) )
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
			Local lxTiinvcontCodigo
			lxTiinvcontCodigo = .Codigo

			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Codigo" as "Codigo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Descrip" as "Descripcion", "Faltafw" as "Fechaaltafw", "Fechad" as "Fechadesde", "Fechah" as "Fechahasta", "Artdesde" as "Articulodesde", "Arthasta" as "Articulohasta", "Coldesde" as "Colordesde", "Colhasta" as "Colorhasta", "Taldesde" as "Talledesde", "Talhasta" as "Tallehasta", "Provdesde" as "Proveedordesde", "Provhasta" as "Proveedorhasta", "Unmeddesde" as "Unidaddemedidadesde", "Unmedhasta" as "Unidaddemedidahasta", "Matdesde" as "Materialdesde", "Mathasta" as "Materialhasta", "Mobs" as "Obs" from ZooLogic.TIINVCONT where "Codigo" = <<lxTiinvcontCodigo>> and  TIINVCONT.CODIGO != 0
			endtext
			use in select('c_TIINVENTARIOACONT')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIINVENTARIOACONT', set( 'Datasession' ) )

			if reccount( 'c_TIINVENTARIOACONT' ) = 0
				llRetorno = .f.
			else
			endif
		endwith
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function VerificarExistenciaClavePrimaria( txVal as Variant ) as Boolean
		local llRetorno as boolean,lxTiinvcontCodigo as Variant
		llRetorno = .t.
		lxTiinvcontCodigo = txVal
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select count( * ) as CantidadDeRegistros from ZooLogic.TIINVCONT where "Codigo" = <<lxTiinvcontCodigo>> and  TIINVCONT.CODIGO != 0
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
				lcOrden =  str( .Codigo, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Codigo" as "Codigo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Descrip" as "Descripcion", "Faltafw" as "Fechaaltafw", "Fechad" as "Fechadesde", "Fechah" as "Fechahasta", "Artdesde" as "Articulodesde", "Arthasta" as "Articulohasta", "Coldesde" as "Colordesde", "Colhasta" as "Colorhasta", "Taldesde" as "Talledesde", "Talhasta" as "Tallehasta", "Provdesde" as "Proveedordesde", "Provhasta" as "Proveedorhasta", "Unmeddesde" as "Unidaddemedidadesde", "Unmedhasta" as "Unidaddemedidahasta", "Matdesde" as "Materialdesde", "Mathasta" as "Materialhasta", "Mobs" as "Obs" from ZooLogic.TIINVCONT where  TIINVCONT.CODIGO != 0 order by CODIGO
			endtext
			use in select('c_TIINVENTARIOACONT')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIINVENTARIOACONT', set( 'Datasession' ) )
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
				lcOrden =  str( .Codigo, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Codigo" as "Codigo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Descrip" as "Descripcion", "Faltafw" as "Fechaaltafw", "Fechad" as "Fechadesde", "Fechah" as "Fechahasta", "Artdesde" as "Articulodesde", "Arthasta" as "Articulohasta", "Coldesde" as "Colordesde", "Colhasta" as "Colorhasta", "Taldesde" as "Talledesde", "Talhasta" as "Tallehasta", "Provdesde" as "Proveedordesde", "Provhasta" as "Proveedorhasta", "Unmeddesde" as "Unidaddemedidadesde", "Unmedhasta" as "Unidaddemedidahasta", "Matdesde" as "Materialdesde", "Mathasta" as "Materialhasta", "Mobs" as "Obs" from ZooLogic.TIINVCONT where  str( CODIGO, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  TIINVCONT.CODIGO != 0 order by CODIGO
			endtext
			use in select('c_TIINVENTARIOACONT')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIINVENTARIOACONT', set( 'Datasession' ) )
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
				lcOrden =  str( .Codigo, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Codigo" as "Codigo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Descrip" as "Descripcion", "Faltafw" as "Fechaaltafw", "Fechad" as "Fechadesde", "Fechah" as "Fechahasta", "Artdesde" as "Articulodesde", "Arthasta" as "Articulohasta", "Coldesde" as "Colordesde", "Colhasta" as "Colorhasta", "Taldesde" as "Talledesde", "Talhasta" as "Tallehasta", "Provdesde" as "Proveedordesde", "Provhasta" as "Proveedorhasta", "Unmeddesde" as "Unidaddemedidadesde", "Unmedhasta" as "Unidaddemedidahasta", "Matdesde" as "Materialdesde", "Mathasta" as "Materialhasta", "Mobs" as "Obs" from ZooLogic.TIINVCONT where  str( CODIGO, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  TIINVCONT.CODIGO != 0 order by CODIGO desc
			endtext
			use in select('c_TIINVENTARIOACONT')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIINVENTARIOACONT', set( 'Datasession' ) )
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
				lcOrden =  str( .Codigo, 8, 0)
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				select top 1 "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Codigo" as "Codigo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Descrip" as "Descripcion", "Faltafw" as "Fechaaltafw", "Fechad" as "Fechadesde", "Fechah" as "Fechahasta", "Artdesde" as "Articulodesde", "Arthasta" as "Articulohasta", "Coldesde" as "Colordesde", "Colhasta" as "Colorhasta", "Taldesde" as "Talledesde", "Talhasta" as "Tallehasta", "Provdesde" as "Proveedordesde", "Provhasta" as "Proveedorhasta", "Unmeddesde" as "Unidaddemedidadesde", "Unmedhasta" as "Unidaddemedidahasta", "Matdesde" as "Materialdesde", "Mathasta" as "Materialhasta", "Mobs" as "Obs" from ZooLogic.TIINVCONT where  TIINVCONT.CODIGO != 0 order by CODIGO desc
			endtext
			use in select('c_TIINVENTARIOACONT')
			this.oConexion.EjecutarSql( lcSentencia, 'c_TIINVENTARIOACONT', set( 'Datasession' ) )
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
				lcFiltroCodigo = ' and ' + .cCampoClavePrimaria + ' <> ' + transform( .oEntidad.CODIGO )
			endif
			lcFiltro = lcCampo + ' = ' + goLibrerias.ValorAString(lxValor) + lcFiltroCodigo
			local lcXml as string
			lcXml = this.oConexion.EjecutarSql( "select Fectrans,Fecimpo,Fmodifw,Fecexpo,Codigo,Bdmodifw,Esttrans,Haltafw,Horaexpo,Bdaltafw,Horaimpo" + ;
",Vmodifw,Zadsfw,Valtafw,Umodifw,Hmodifw,Saltafw,Smodifw,Ualtafw,Descrip,Faltafw,Fechad,Fechah,Artdes" + ;
"de,Arthasta,Coldesde,Colhasta,Taldesde,Talhasta,Provdesde,Provhasta,Unmeddesde,Unmedhasta,Matdesde,M" + ;
"athasta,Mobs" + ;
" from ZooLogic.TIINVCONT where  TIINVCONT.CODIGO != 0 and " + lcFiltro )
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
			local  lxTiinvcontFectrans, lxTiinvcontFecimpo, lxTiinvcontFmodifw, lxTiinvcontFecexpo, lxTiinvcontCodigo, lxTiinvcontBdmodifw, lxTiinvcontEsttrans, lxTiinvcontHaltafw, lxTiinvcontHoraexpo, lxTiinvcontBdaltafw, lxTiinvcontHoraimpo, lxTiinvcontVmodifw, lxTiinvcontZadsfw, lxTiinvcontValtafw, lxTiinvcontUmodifw, lxTiinvcontHmodifw, lxTiinvcontSaltafw, lxTiinvcontSmodifw, lxTiinvcontUaltafw, lxTiinvcontDescrip, lxTiinvcontFaltafw, lxTiinvcontFechad, lxTiinvcontFechah, lxTiinvcontArtdesde, lxTiinvcontArthasta, lxTiinvcontColdesde, lxTiinvcontColhasta, lxTiinvcontTaldesde, lxTiinvcontTalhasta, lxTiinvcontProvdesde, lxTiinvcontProvhasta, lxTiinvcontUnmeddesde, lxTiinvcontUnmedhasta, lxTiinvcontMatdesde, lxTiinvcontMathasta, lxTiinvcontMobs
				lxTiinvcontFectrans = ctod( '  /  /    ' )			lxTiinvcontFecimpo = ctod( '  /  /    ' )			lxTiinvcontFmodifw = ctod( '  /  /    ' )			lxTiinvcontFecexpo = ctod( '  /  /    ' )			lxTiinvcontCodigo = 0			lxTiinvcontBdmodifw = []			lxTiinvcontEsttrans = []			lxTiinvcontHaltafw = []			lxTiinvcontHoraexpo = []			lxTiinvcontBdaltafw = []			lxTiinvcontHoraimpo = []			lxTiinvcontVmodifw = []			lxTiinvcontZadsfw = []			lxTiinvcontValtafw = []			lxTiinvcontUmodifw = []			lxTiinvcontHmodifw = []			lxTiinvcontSaltafw = []			lxTiinvcontSmodifw = []			lxTiinvcontUaltafw = []			lxTiinvcontDescrip = []			lxTiinvcontFaltafw = ctod( '  /  /    ' )			lxTiinvcontFechad = ctod( '  /  /    ' )			lxTiinvcontFechah = ctod( '  /  /    ' )			lxTiinvcontArtdesde = []			lxTiinvcontArthasta = []			lxTiinvcontColdesde = []			lxTiinvcontColhasta = []			lxTiinvcontTaldesde = []			lxTiinvcontTalhasta = []			lxTiinvcontProvdesde = []			lxTiinvcontProvhasta = []			lxTiinvcontUnmeddesde = []			lxTiinvcontUnmedhasta = []			lxTiinvcontMatdesde = []			lxTiinvcontMathasta = []			lxTiinvcontMobs = []
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			local lxCodigo
			if empty( this.oEntidad.Codigo )
				lxCodigo = null
			else
				lxCodigo = this.oEntidad.Codigo
			endif
			this.oSP.EliminarEnTIINVENTARIOACONTDetalle(lxCodigo)
			this.oConexion.EjecutarSql( [delete from ZooLogic.TIINVCONT where "CODIGO" = ] + transform( .oEntidad.CODIGO )+ goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
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
			lcTabla = 'TIINVCONT' + '_' + tcCampo
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
		lcWhere = " Where  TIINVCONT.CODIGO != 0"
		lcAtributos = tcAtributos
		if empty( tcFunc )
			If empty( tcAtributos )
				text to lcAtributos textmerge noshow
					"Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Codigo" as "Codigo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Descrip" as "Descripcion", "Faltafw" as "Fechaaltafw", "Fechad" as "Fechadesde", "Fechah" as "Fechahasta", "Artdesde" as "Articulodesde", "Arthasta" as "Articulohasta", "Coldesde" as "Colordesde", "Colhasta" as "Colorhasta", "Taldesde" as "Talledesde", "Talhasta" as "Tallehasta", "Provdesde" as "Proveedordesde", "Provhasta" as "Proveedorhasta", "Unmeddesde" as "Unidaddemedidadesde", "Unmedhasta" as "Unidaddemedidahasta", "Matdesde" as "Materialdesde", "Mathasta" as "Materialhasta", "Mobs" as "Obs"
				endtext
			Else
				lcAtributos = This.ObtenerCamposSelectEntidad( tcAtributos )
			endif
		endif
		return this.ObtenerDatos( lcAtributos, tcHaving, tcOrder, tcFunc, lcWhere, 'TIINVCONT', '', tnTope )
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
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
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
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'DESCRIPCION'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'DESCRIP AS DESCRIPCION'
				Case lcAtributo == 'FECHAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FALTAFW AS FECHAALTAFW'
				Case lcAtributo == 'FECHADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAD AS FECHADESDE'
				Case lcAtributo == 'FECHAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECHAH AS FECHAHASTA'
				Case lcAtributo == 'ARTICULODESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTDESDE AS ARTICULODESDE'
				Case lcAtributo == 'ARTICULOHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ARTHASTA AS ARTICULOHASTA'
				Case lcAtributo == 'COLORDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLDESDE AS COLORDESDE'
				Case lcAtributo == 'COLORHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'COLHASTA AS COLORHASTA'
				Case lcAtributo == 'TALLEDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALDESDE AS TALLEDESDE'
				Case lcAtributo == 'TALLEHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TALHASTA AS TALLEHASTA'
				Case lcAtributo == 'PROVEEDORDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROVDESDE AS PROVEEDORDESDE'
				Case lcAtributo == 'PROVEEDORHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'PROVHASTA AS PROVEEDORHASTA'
				Case lcAtributo == 'UNIDADDEMEDIDADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UNMEDDESDE AS UNIDADDEMEDIDADESDE'
				Case lcAtributo == 'UNIDADDEMEDIDAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UNMEDHASTA AS UNIDADDEMEDIDAHASTA'
				Case lcAtributo == 'MATERIALDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MATDESDE AS MATERIALDESDE'
				Case lcAtributo == 'MATERIALHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MATHASTA AS MATERIALHASTA'
				Case lcAtributo == 'OBS'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MOBS AS OBS'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
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
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'DESCRIPCION'
				lcCampo = 'DESCRIP'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAALTAFW'
				lcCampo = 'FALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHADESDE'
				lcCampo = 'FECHAD'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAHASTA'
				lcCampo = 'FECHAH'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULODESDE'
				lcCampo = 'ARTDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'ARTICULOHASTA'
				lcCampo = 'ARTHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'COLORDESDE'
				lcCampo = 'COLDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'COLORHASTA'
				lcCampo = 'COLHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'TALLEDESDE'
				lcCampo = 'TALDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'TALLEHASTA'
				lcCampo = 'TALHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDORDESDE'
				lcCampo = 'PROVDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'PROVEEDORHASTA'
				lcCampo = 'PROVHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'UNIDADDEMEDIDADESDE'
				lcCampo = 'UNMEDDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'UNIDADDEMEDIDAHASTA'
				lcCampo = 'UNMEDHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'MATERIALDESDE'
				lcCampo = 'MATDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'MATERIALHASTA'
				lcCampo = 'MATHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'OBS'
				lcCampo = 'MOBS'
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
			local  lxTiinvcontFectrans, lxTiinvcontFecimpo, lxTiinvcontFmodifw, lxTiinvcontFecexpo, lxTiinvcontCodigo, lxTiinvcontBdmodifw, lxTiinvcontEsttrans, lxTiinvcontHaltafw, lxTiinvcontHoraexpo, lxTiinvcontBdaltafw, lxTiinvcontHoraimpo, lxTiinvcontVmodifw, lxTiinvcontZadsfw, lxTiinvcontValtafw, lxTiinvcontUmodifw, lxTiinvcontHmodifw, lxTiinvcontSaltafw, lxTiinvcontSmodifw, lxTiinvcontUaltafw, lxTiinvcontDescrip, lxTiinvcontFaltafw, lxTiinvcontFechad, lxTiinvcontFechah, lxTiinvcontArtdesde, lxTiinvcontArthasta, lxTiinvcontColdesde, lxTiinvcontColhasta, lxTiinvcontTaldesde, lxTiinvcontTalhasta, lxTiinvcontProvdesde, lxTiinvcontProvhasta, lxTiinvcontUnmeddesde, lxTiinvcontUnmedhasta, lxTiinvcontMatdesde, lxTiinvcontMathasta, lxTiinvcontMobs
				lxTiinvcontFectrans =  .Fechatransferencia			lxTiinvcontFecimpo =  .Fechaimpo			lxTiinvcontFmodifw =  .Fechamodificacionfw			lxTiinvcontFecexpo =  .Fechaexpo			lxTiinvcontCodigo =  .Codigo			lxTiinvcontBdmodifw =  .Basededatosmodificacionfw			lxTiinvcontEsttrans =  .Estadotransferencia			lxTiinvcontHaltafw =  .Horaaltafw			lxTiinvcontHoraexpo =  .Horaexpo			lxTiinvcontBdaltafw =  .Basededatosaltafw			lxTiinvcontHoraimpo =  .Horaimpo			lxTiinvcontVmodifw =  .Versionmodificacionfw			lxTiinvcontZadsfw =  .Zadsfw			lxTiinvcontValtafw =  .Versionaltafw			lxTiinvcontUmodifw =  .Usuariomodificacionfw			lxTiinvcontHmodifw =  .Horamodificacionfw			lxTiinvcontSaltafw =  .Seriealtafw			lxTiinvcontSmodifw =  .Seriemodificacionfw			lxTiinvcontUaltafw =  .Usuarioaltafw			lxTiinvcontDescrip =  .Descripcion			lxTiinvcontFaltafw =  .Fechaaltafw			lxTiinvcontFechad =  .Fechadesde			lxTiinvcontFechah =  .Fechahasta			lxTiinvcontArtdesde =  .Articulodesde			lxTiinvcontArthasta =  .Articulohasta			lxTiinvcontColdesde =  .Colordesde			lxTiinvcontColhasta =  .Colorhasta			lxTiinvcontTaldesde =  .Talledesde			lxTiinvcontTalhasta =  .Tallehasta			lxTiinvcontProvdesde =  .Proveedordesde			lxTiinvcontProvhasta =  .Proveedorhasta			lxTiinvcontUnmeddesde =  .Unidaddemedidadesde			lxTiinvcontUnmedhasta =  .Unidaddemedidahasta			lxTiinvcontMatdesde =  .Materialdesde			lxTiinvcontMathasta =  .Materialhasta			lxTiinvcontMobs =  .Obs
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.TIINVCONT ( "Fectrans","Fecimpo","Fmodifw","Fecexpo","Codigo","Bdmodifw","Esttrans","Haltafw","Horaexpo","Bdaltafw","Horaimpo","Vmodifw","Zadsfw","Valtafw","Umodifw","Hmodifw","Saltafw","Smodifw","Ualtafw","Descrip","Faltafw","Fechad","Fechah","Artdesde","Arthasta","Coldesde","Colhasta","Taldesde","Talhasta","Provdesde","Provhasta","Unmeddesde","Unmedhasta","Matdesde","Mathasta","Mobs" ) values ( <<"'" + this.ConvertirDateSql( lxTiinvcontFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvcontFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvcontFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvcontFecexpo ) + "'" >>, <<lxTiinvcontCodigo >>, <<"'" + this.FormatearTextoSql( lxTiinvcontBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontDescrip ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvcontFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvcontFechad ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvcontFechah ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontArtdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontArthasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontColdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontColhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontTaldesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontTalhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontProvdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontProvhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontUnmeddesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontUnmedhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontMatdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontMathasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontMobs ) + "'" >> )
		endtext
		loColeccion.cTabla = 'TIINVCONT' 
		loColeccion.agregar( strtran( lcSentencia, chr( 9 ), '' ) )
		With this
			local lcValorClavePrimariaString as String
			lcValorClavePrimariaString = transform( this.oEntidad.CODIGO )
		EndWith
		return loColeccion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerSentenciasUpdate() as zooColeccion of zooColeccion.prg
		local loColeccion as zooColeccion of zooColeccion.prg, lcValores as string, lcFiltro as string, loItem as object, lcSentencia as string, lcSentencia as string
		loColeccion = _screen.zoo.CrearObjeto( 'zooColeccion' )
		loColeccion.addproperty( 'cTabla', '' )
		with this.oEntidad
			local  lxTiinvcontFectrans, lxTiinvcontFecimpo, lxTiinvcontFmodifw, lxTiinvcontFecexpo, lxTiinvcontCodigo, lxTiinvcontBdmodifw, lxTiinvcontEsttrans, lxTiinvcontHaltafw, lxTiinvcontHoraexpo, lxTiinvcontBdaltafw, lxTiinvcontHoraimpo, lxTiinvcontVmodifw, lxTiinvcontZadsfw, lxTiinvcontValtafw, lxTiinvcontUmodifw, lxTiinvcontHmodifw, lxTiinvcontSaltafw, lxTiinvcontSmodifw, lxTiinvcontUaltafw, lxTiinvcontDescrip, lxTiinvcontFaltafw, lxTiinvcontFechad, lxTiinvcontFechah, lxTiinvcontArtdesde, lxTiinvcontArthasta, lxTiinvcontColdesde, lxTiinvcontColhasta, lxTiinvcontTaldesde, lxTiinvcontTalhasta, lxTiinvcontProvdesde, lxTiinvcontProvhasta, lxTiinvcontUnmeddesde, lxTiinvcontUnmedhasta, lxTiinvcontMatdesde, lxTiinvcontMathasta, lxTiinvcontMobs
				lxTiinvcontFectrans =  .Fechatransferencia			lxTiinvcontFecimpo =  .Fechaimpo			lxTiinvcontFmodifw =  .Fechamodificacionfw			lxTiinvcontFecexpo =  .Fechaexpo			lxTiinvcontCodigo =  .Codigo			lxTiinvcontBdmodifw =  .Basededatosmodificacionfw			lxTiinvcontEsttrans =  .Estadotransferencia			lxTiinvcontHaltafw =  .Horaaltafw			lxTiinvcontHoraexpo =  .Horaexpo			lxTiinvcontBdaltafw =  .Basededatosaltafw			lxTiinvcontHoraimpo =  .Horaimpo			lxTiinvcontVmodifw =  .Versionmodificacionfw			lxTiinvcontZadsfw =  .Zadsfw			lxTiinvcontValtafw =  .Versionaltafw			lxTiinvcontUmodifw =  .Usuariomodificacionfw			lxTiinvcontHmodifw =  .Horamodificacionfw			lxTiinvcontSaltafw =  .Seriealtafw			lxTiinvcontSmodifw =  .Seriemodificacionfw			lxTiinvcontUaltafw =  .Usuarioaltafw			lxTiinvcontDescrip =  .Descripcion			lxTiinvcontFaltafw =  .Fechaaltafw			lxTiinvcontFechad =  .Fechadesde			lxTiinvcontFechah =  .Fechahasta			lxTiinvcontArtdesde =  .Articulodesde			lxTiinvcontArthasta =  .Articulohasta			lxTiinvcontColdesde =  .Colordesde			lxTiinvcontColhasta =  .Colorhasta			lxTiinvcontTaldesde =  .Talledesde			lxTiinvcontTalhasta =  .Tallehasta			lxTiinvcontProvdesde =  .Proveedordesde			lxTiinvcontProvhasta =  .Proveedorhasta			lxTiinvcontUnmeddesde =  .Unidaddemedidadesde			lxTiinvcontUnmedhasta =  .Unidaddemedidahasta			lxTiinvcontMatdesde =  .Materialdesde			lxTiinvcontMathasta =  .Materialhasta			lxTiinvcontMobs =  .Obs
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = transform( this.oEntidad.CODIGO )

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  TIINVCONT.CODIGO != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.TIINVCONT set "Fectrans" = <<"'" + this.ConvertirDateSql( lxTiinvcontFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxTiinvcontFecimpo ) + "'">>, "Fmodifw" = <<"'" + this.ConvertirDateSql( lxTiinvcontFmodifw ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxTiinvcontFecexpo ) + "'">>, "Codigo" = <<lxTiinvcontCodigo>>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxTiinvcontBdmodifw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxTiinvcontEsttrans ) + "'">>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxTiinvcontHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxTiinvcontHoraexpo ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxTiinvcontBdaltafw ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxTiinvcontHoraimpo ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxTiinvcontVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxTiinvcontZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxTiinvcontValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxTiinvcontUmodifw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxTiinvcontHmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxTiinvcontSaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxTiinvcontSmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxTiinvcontUaltafw ) + "'">>, "Descrip" = <<"'" + this.FormatearTextoSql( lxTiinvcontDescrip ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxTiinvcontFaltafw ) + "'">>, "Fechad" = <<"'" + this.ConvertirDateSql( lxTiinvcontFechad ) + "'">>, "Fechah" = <<"'" + this.ConvertirDateSql( lxTiinvcontFechah ) + "'">>, "Artdesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontArtdesde ) + "'">>, "Arthasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontArthasta ) + "'">>, "Coldesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontColdesde ) + "'">>, "Colhasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontColhasta ) + "'">>, "Taldesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontTaldesde ) + "'">>, "Talhasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontTalhasta ) + "'">>, "Provdesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontProvdesde ) + "'">>, "Provhasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontProvhasta ) + "'">>, "Unmeddesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontUnmeddesde ) + "'">>, "Unmedhasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontUnmedhasta ) + "'">>, "Matdesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontMatdesde ) + "'">>, "Mathasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontMathasta ) + "'">>, "Mobs" = <<"'" + this.FormatearTextoSql( lxTiinvcontMobs ) + "'">> where << lcFiltro >>
			endtext
		loColeccion.cTabla = 'TIINVCONT' 
		loColeccion.agregar( strtran(  lcSentencia, chr( 9 ), '' ) )
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
			lcValorClavePrimariaString = transform( this.oEntidad.CODIGO )

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  TIINVCONT.CODIGO != 0]
		loColeccion.Agregar( 'delete from ZooLogic.TIINVCONT where ' + lcFiltro )
			loColeccion.cTabla = 'TIINVCONT' 
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
			lcXml = this.oConexion.EjecutarSql( "select count( * ) as Total from ZooLogic.TIINVCONT where  TIINVCONT.CODIGO != 0" )
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
			lcXml = this.oConexion.EjecutarSql( "select TimeStamp from ZooLogic.TIINVCONT where CODIGO = " + transform( this.oEntidad.CODIGO )+ " and  TIINVCONT.CODIGO != 0" )
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
					if empty( .oNumeraciones.ObtenerServicio('CODIGO') ) and iif( type( '.CODIGO' ) = 'C', int( val( .CODIGO ) ),.CODIGO ) = .oNumeraciones.UltimoNumero( 'CODIGO' )
						.oNumeraciones.Actualizar( 'CODIGO' )
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
					.CODIGO = .oNumeraciones.grabar( 'CODIGO' )
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
		lcCursor = This.oEntidad.cPrefijoRecibir + 'TIINVENTARIOACONT'
		select( lcCursor )
		scan all
			ldFecha = goLibrerias.ObtenerFecha()
			lcHora = goLibrerias.ObtenerHora()
			lcIdentificadorParaLoguear = '---------------> ' + this.ObtenerIdentificadorParaLoguear( lcCursor )
			this.oConexion.EjecutarSql( [Select * From ZooLogic.TIINVCONT Where CODIGO = ] + transform( &lcCursor..CODIGO ), 'curSeek', this.datasessionid )
			if reccount( 'curSeek' ) > 0
				if This.ActualizaEnRecepcion() and Evaluate( "dtos( " + lcCursor + ".FModiFW ) + " + lcCursor + ".HModiFW >= dtos( goServicios.Librerias.ObtenerFechaFormateada( CurSeek.FModiFW ) )+ CurSeek.HModiFW" )
					Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.TIINVCONT set  FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, CODIGO = ] + transform( &lcCursor..CODIGO )+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, Descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"+ [, FECHAD = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHAD ) + "'"+ [, FECHAH = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHAH ) + "'"+ [, ArtDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ArtDesde ) + "'"+ [, ArtHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ArtHasta ) + "'"+ [, ColDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ColDesde ) + "'"+ [, ColHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ColHasta ) + "'"+ [, TalDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..TalDesde ) + "'"+ [, TalHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..TalHasta ) + "'"+ [, ProvDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ProvDesde ) + "'"+ [, ProvHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ProvHasta ) + "'"+ [, UnMedDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..UnMedDesde ) + "'"+ [, UnMedHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..UnMedHasta ) + "'"+ [, MatDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..MatDesde ) + "'"+ [, MatHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..MatHasta ) + "'"+ [, MObs = ] + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'" + [ Where CODIGO = ] + transform( &lcCursor..CODIGO ) )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FECTRANS, FECIMPO, FMODIFW, FECEXPO, CODIGO, BDMODIFW, ESTTRANS, HALTAFW, HORAEXPO, BDALTAFW, HORAIMPO, VMODIFW, ZADSFW, VALTAFW, UMODIFW, HMODIFW, SALTAFW, SMODIFW, UALTAFW, Descrip, FAltaFW, FECHAD, FECHAH, ArtDesde, ArtHasta, ColDesde, ColHasta, TalDesde, TalHasta, ProvDesde, ProvHasta, UnMedDesde, UnMedHasta, MatDesde, MatHasta, MObs
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + transform( &lcCursor..CODIGO ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FAltaFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHAD ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHAH ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ArtDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ArtHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ColDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ColHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TalDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..TalHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ProvDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ProvHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UnMedDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UnMedHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MatDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..MatHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'"
lcValoresCampos = substr(lcValoresCampos,2) 

				this.oConexion.EjecutarSql( [Insert into ZooLogic.TIINVCONT ( ] + lcCampos + [ ) values ( ] + lcValoresCampos +[ ) ] + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre )  )
				this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( alta ).', tlLoguear )
			endif
		endscan
		delete from &lcCursor where empty( ESTTRANS )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirDetalles() As Void
		local lcCursor as String, lcMemo as String, lcDetalle as String
		lcCursor = This.oEntidad.cPrefijoRecibir + 'TIINVENTARIOACONT'
		if This.ActualizaEnRecepcion()
	endif
	Use in select( 'cExistentes' )
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	protected function CrearCursorMemo( tcCursorACrear as String, tcTablaConMemo as String ) as Void
		create cursor &tcCursorACrear ( CODIGO N (8) , Orden N(16), texto C(80))
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function RecibirComponentes() As Void
		
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function ObtenerIdentificadorParaLoguear( tcCursor as String ) As String
		local lcRetorno as String, lnCC as String , loCC as Object, lni as Integer, lcSecuencia as String
		lcRetorno = this.oEntidad.cDescripcion 
		lcRetorno = lcRetorno + ' - Número: ' + transform( &tcCursor..CODIGO     )
		Return lcRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function EsAliasDeProceso( tcAlias As String, tcPrefijo as string ) As Boolean
		local llRetorno as Boolean, lcAlias as String, lcPrefijo As String
		llRetorno = .F.
		lcAlias = upper( alltrim( tcAlias ) )
		lcPrefijo = upper( alltrim( tcPrefijo ) )
		Do Case
			Case  lcAlias == lcPrefijo + 'TIINVENTARIOACONT'
				llRetorno = .T.
			Case  lcAlias == lcPrefijo + 'TIINVENTARIOACONT_ZADSFW'
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

				toConexion.EjecutarNonQuery( 'Delete top (' + transform( This.nCantABorrar ) + ') From ZooLogic.TablaTrabajo_TIInvCont')

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
		lcCursor = This.oEntidad.cPrefijoImportar + 'TIINVENTARIOACONT'
		select( lcCursor )
		llRetorno = .T.
		lxVar = &lcCursor..CODIGO
		llCondicion = isnull( lxVar )
		if llCondicion
			this.oEntidad.Loguear( 'No se puede importar la entidad TIINVENTARIOACONT. Hay un error en el diseño de importación.' )
			this.oEntidad.Loguear( 'Las claves principales y candidatas deben estar cargadas en el diseño.' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDuplicaciones() as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TIINVENTARIOACONT'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		select recno() as _Rec, * from &lcCursor into cursor CurConRecno
		select max( _Rec ) as Maximo,CODIGO as Clave from CurConRecno into cursor RepMax Group by Clave having count( * ) > 1
		Index on Clave tag Clave
		delete for seek( CODIGO, 'RepMax', 'Clave' ) and recno( lcCursor ) != RepMax.Maximo in &lcCursor
		Use in select( 'CurConRecno' )
		Use in select( 'RepMax' )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function EliminarDatosInvalidos( toConexion as Object ) as boolean
		local lcCursor as String
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TIINVENTARIOACONT'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECEXPO   
		* Validar ANTERIORES A 1/1/1753  FAltaFW   
		* Validar ANTERIORES A 1/1/1753  FECHAD    
		* Validar ANTERIORES A 1/1/1753  FECHAH    
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected Function CrearTablaDeTrabajo( toConexion as Object ) as void
		toConexion.EjecutarNonQuery( 'Use [' + goLibrerias.obtenernombresucursal( alltrim( _Screen.zoo.app.cSucursalActiva ) ) + ']' )
		local lcSentencia as string
		text to lcSentencia textmerge noshow
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_TIInvCont') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_TIInvCont
Create Table ZooLogic.TablaTrabajo_TIInvCont ( 
 "Nrolinea" numeric( 20, 0 ) null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"fmodifw" datetime  null, 
"fecexpo" datetime  null, 
"codigo" numeric( 8, 0 )  null, 
"bdmodifw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"hmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"smodifw" char( 7 )  null, 
"ualtafw" char( 100 )  null, 
"descrip" char( 40 )  null, 
"faltafw" datetime  null, 
"fechad" datetime  null, 
"fechah" datetime  null, 
"artdesde" char( 13 )  null, 
"arthasta" char( 13 )  null, 
"coldesde" char( 2 )  null, 
"colhasta" char( 2 )  null, 
"taldesde" char( 3 )  null, 
"talhasta" char( 3 )  null, 
"provdesde" char( 5 )  null, 
"provhasta" char( 5 )  null, 
"unmeddesde" char( 3 )  null, 
"unmedhasta" char( 3 )  null, 
"matdesde" char( 10 )  null, 
"mathasta" char( 10 )  null, 
"mobs" char( 20 )  null )
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
		********Agrego el trigger a la tabla
		if this.oEntidad.VerificarContexto( 'CB' )
			lcSentencia = this.ObtenerTriggerDeleteTransferencia( 'TablaTrabajo_TIInvCont' )
		else
			lcSentencia = this.ObtenerTriggerDeleteImportacion( 'TablaTrabajo_TIInvCont' )
		endif
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	*--------------------------------------------------------------------------------------------------------
	protected function CargarTablaDeTrabajo( toConexion as Object ) as void
		local loManejador as object, lcCursor as string
		loManejador = _Screen.DotNetBridge.CrearObjeto( 'ZooLogicSA.ManejadorArchivos.CopiaMasiva' )
		if this.oEntidad.VerificarContexto( 'CB' )
			lcCursor = This.oEntidad.cPrefijoRecibir + 'TIINVENTARIOACONT'
		else
			lcCursor = this.oEntidad.cPrefijoImportar + this.oEntidad.ObtenerNombre()
		endif
		with loManejador
			if this.oEntidad.VerificarContexto( 'CB' )
			else
				.AgregarMapeo('Nrolinea','Nrolinea')
			endif
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('smodifw','smodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('descrip','descrip')
			.AgregarMapeo('faltafw','faltafw')
			.AgregarMapeo('fechad','fechad')
			.AgregarMapeo('fechah','fechah')
			.AgregarMapeo('artdesde','artdesde')
			.AgregarMapeo('arthasta','arthasta')
			.AgregarMapeo('coldesde','coldesde')
			.AgregarMapeo('colhasta','colhasta')
			.AgregarMapeo('taldesde','taldesde')
			.AgregarMapeo('talhasta','talhasta')
			.AgregarMapeo('provdesde','provdesde')
			.AgregarMapeo('provhasta','provhasta')
			.AgregarMapeo('unmeddesde','unmeddesde')
			.AgregarMapeo('unmedhasta','unmedhasta')
			.AgregarMapeo('matdesde','matdesde')
			.AgregarMapeo('mathasta','mathasta')
			.AgregarMapeo('mobs','mobs')
			.CadenaConexionOrigen = 'Provider=VFPOLEDB.1;Data Source= ' +  justpath( dbf( lcCursor ) )
			.CadenaConexionDestino = this.oConexion.oManagerConexionASql.ObtenerCadenaConexionNet()
			.NombreTablaSqlServer = 'ZooLogic.TablaTrabajo_TIInvCont'
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
				Update t Set t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECHAD = isnull( d.FECHAD, t.FECHAD ),t.FECHAH = isnull( d.FECHAH, t.FECHAH ),t.ARTDESDE = isnull( d.ARTDESDE, t.ARTDESDE ),t.ARTHASTA = isnull( d.ARTHASTA, t.ARTHASTA ),t.COLDESDE = isnull( d.COLDESDE, t.COLDESDE ),t.COLHASTA = isnull( d.COLHASTA, t.COLHASTA ),t.TALDESDE = isnull( d.TALDESDE, t.TALDESDE ),t.TALHASTA = isnull( d.TALHASTA, t.TALHASTA ),t.PROVDESDE = isnull( d.PROVDESDE, t.PROVDESDE ),t.PROVHASTA = isnull( d.PROVHASTA, t.PROVHASTA ),t.UNMEDDESDE = isnull( d.UNMEDDESDE, t.UNMEDDESDE ),t.UNMEDHASTA = isnull( d.UNMEDHASTA, t.UNMEDHASTA ),t.MATDESDE = isnull( d.MATDESDE, t.MATDESDE ),t.MATHASTA = isnull( d.MATHASTA, t.MATHASTA ),t.MOBS = isnull( d.MOBS, t.MOBS )
					from ZooLogic.TIINVCONT t inner join deleted d 
							 on t.CODIGO = d.CODIGO
				-- Fin Updates
				insert into ZooLogic.TIINVCONT(Fectrans,Fecimpo,Fmodifw,Fecexpo,Codigo,Bdmodifw,Esttrans,Haltafw,Horaexpo,Bdaltafw,Horaimpo,Vmodifw,Zadsfw,Valtafw,Umodifw,Hmodifw,Saltafw,Smodifw,Ualtafw,Descrip,Faltafw,Fechad,Fechah,Artdesde,Arthasta,Coldesde,Colhasta,Taldesde,Talhasta,Provdesde,Provhasta,Unmeddesde,Unmedhasta,Matdesde,Mathasta,Mobs)
					Select isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),isnull( d.FMODIFW,''),isnull( d.FECEXPO,''),isnull( d.CODIGO,0),isnull( d.BDMODIFW,''),isnull( d.ESTTRANS,''),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.BDALTAFW,''),isnull( d.HORAIMPO,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.HMODIFW,''),isnull( d.SALTAFW,''),isnull( d.SMODIFW,''),isnull( d.UALTAFW,''),isnull( d.DESCRIP,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECHAD,''),isnull( d.FECHAH,''),isnull( d.ARTDESDE,''),isnull( d.ARTHASTA,''),isnull( d.COLDESDE,''),isnull( d.COLHASTA,''),isnull( d.TALDESDE,''),isnull( d.TALHASTA,''),isnull( d.PROVDESDE,''),isnull( d.PROVHASTA,''),isnull( d.UNMEDDESDE,''),isnull( d.UNMEDHASTA,''),isnull( d.MATDESDE,''),isnull( d.MATHASTA,''),isnull( d.MOBS,'')
						From deleted d left join ZooLogic.TIINVCONT pk 
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
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID('ZooLogic.TablaTrabajo_TIInvCont') AND type in ('U')) DROP TABLE ZooLogic.TablaTrabajo_TIInvCont
		endtext
		toConexion.EjecutarNonQuery( lcSentencia )
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Cargar() as Boolean
		local llRetorno As Boolean
		local loError as Exception, loEx as Exception
		with this.oEntidad
			llRetorno = .T.
			if reccount( 'c_TIINVENTARIOACONT' ) < 1
				llRetorno = .F.
			else
				Try
					.lCargando = .t.
					dodefault()
					.LimpiarFlag()

					.LimpiarAtributosVirtuales()
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIINVENTARIOACONT.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIINVENTARIOACONT.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIINVENTARIOACONT.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIINVENTARIOACONT.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Codigo = nvl( c_TIINVENTARIOACONT.Codigo, 0 )
					.Basededatosmodificacionfw = nvl( c_TIINVENTARIOACONT.Basededatosmodificacionfw, [] )
					.Estadotransferencia = nvl( c_TIINVENTARIOACONT.Estadotransferencia, [] )
					.Horaaltafw = nvl( c_TIINVENTARIOACONT.Horaaltafw, [] )
					.Horaexpo = nvl( c_TIINVENTARIOACONT.Horaexpo, [] )
					.Basededatosaltafw = nvl( c_TIINVENTARIOACONT.Basededatosaltafw, [] )
					.Horaimpo = nvl( c_TIINVENTARIOACONT.Horaimpo, [] )
					.Versionmodificacionfw = nvl( c_TIINVENTARIOACONT.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_TIINVENTARIOACONT.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_TIINVENTARIOACONT.Usuariomodificacionfw, [] )
					.Horamodificacionfw = nvl( c_TIINVENTARIOACONT.Horamodificacionfw, [] )
					.Seriealtafw = nvl( c_TIINVENTARIOACONT.Seriealtafw, [] )
					.Seriemodificacionfw = nvl( c_TIINVENTARIOACONT.Seriemodificacionfw, [] )
					.Usuarioaltafw = nvl( c_TIINVENTARIOACONT.Usuarioaltafw, [] )
					.Descripcion = nvl( c_TIINVENTARIOACONT.Descripcion, [] )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIINVENTARIOACONT.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechadesde = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIINVENTARIOACONT.Fechadesde, ctod( '  /  /    ' ) ) )
					.Fechahasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIINVENTARIOACONT.Fechahasta, ctod( '  /  /    ' ) ) )
					.Articulodesde = nvl( c_TIINVENTARIOACONT.Articulodesde, [] )
					.Articulohasta = nvl( c_TIINVENTARIOACONT.Articulohasta, [] )
					.Colordesde = nvl( c_TIINVENTARIOACONT.Colordesde, [] )
					.Colorhasta = nvl( c_TIINVENTARIOACONT.Colorhasta, [] )
					.Talledesde = nvl( c_TIINVENTARIOACONT.Talledesde, [] )
					.Tallehasta = nvl( c_TIINVENTARIOACONT.Tallehasta, [] )
					.Proveedordesde = nvl( c_TIINVENTARIOACONT.Proveedordesde, [] )
					.Proveedorhasta = nvl( c_TIINVENTARIOACONT.Proveedorhasta, [] )
					.Unidaddemedidadesde = nvl( c_TIINVENTARIOACONT.Unidaddemedidadesde, [] )
					.Unidaddemedidahasta = nvl( c_TIINVENTARIOACONT.Unidaddemedidahasta, [] )
					.Materialdesde = nvl( c_TIINVENTARIOACONT.Materialdesde, [] )
					.Materialhasta = nvl( c_TIINVENTARIOACONT.Materialhasta, [] )
					.Obs = nvl( c_TIINVENTARIOACONT.Obs, [] )
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
		
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerMemo( tcTabla as String ) as string
		local lcAtributo as string
		lcAtributo = strtran( tcTabla, 'c_', '' )
		return c_TIINVENTARIOACONT.&lcAtributo
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerDate( tcCursor as String, tcAtributo as string ) as date
		return dtoc( &tcCursor..&tcAtributo )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerFechaUltimoUpdateEnTablas() as DateTime
		local lcSentencia as String, ldRetorno as DateTime

		text to lcSentencia textmerge noshow
			SELECT MAX( last_user_update ) as last_update FROM sys.dm_db_index_usage_stats WHERE database_id = DB_ID() AND OBJECT_ID=OBJECT_ID( 'ZooLogic.TIINVCONT' )
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
								from ZooLogic.TIINVCONT 
								Where   TIINVCONT.CODIGO != 0
									and <<tcFiltro>>
							 ) a
					 ) b
					 WHERE nro between <<lnDesde>> and <<lnTope>>
		endtext
		
		lcCursor = sys( 2015 )
		this.oConexion.EjecutarSentencias( lcSQL, "TIINVCONT", "", lcCursor, set("Datasession") )
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
			"Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fmodifw" as "Fechamodificacionfw", "Fecexpo" as "Fechaexpo", "Codigo" as "Codigo", "Bdmodifw" as "Basededatosmodificacionfw", "Esttrans" as "Estadotransferencia", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Bdaltafw" as "Basededatosaltafw", "Horaimpo" as "Horaimpo", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Hmodifw" as "Horamodificacionfw", "Saltafw" as "Seriealtafw", "Smodifw" as "Seriemodificacionfw", "Ualtafw" as "Usuarioaltafw", "Descrip" as "Descripcion", "Faltafw" as "Fechaaltafw", "Fechad" as "Fechadesde", "Fechah" as "Fechahasta", "Artdesde" as "Articulodesde", "Arthasta" as "Articulohasta", "Coldesde" as "Colordesde", "Colhasta" as "Colorhasta", "Taldesde" as "Talledesde", "Talhasta" as "Tallehasta", "Provdesde" as "Proveedordesde", "Provhasta" as "Proveedorhasta", "Unmeddesde" as "Unidaddemedidadesde", "Unmedhasta" as "Unidaddemedidahasta", "Matdesde" as "Materialdesde", "Mathasta" as "Materialhasta", "Mobs" as "Obs"
			endtext
		text to lcSQL textmerge noshow
				SELECT <<lcAtributos>>
					FROM ( 
				    select row_number() over (Order By <<lcOrderBy>>) as nro,
				    count(1) over() as totalRegistros,
				    * from (
							select * 
								from ZooLogic.TIINVCONT 
								Where   TIINVCONT.CODIGO != 0
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
	Tabla = 'TIINVCONT'
	Filtro = " TIINVCONT.CODIGO != 0"
	oEntidad = null
	cEstructura = ''
	cEstructuraDetalle = ''
	cEstructuraSinDetalle = ''
	listadecampos = ''
	Indice = " TIINVCONT.CODIGO != 0"
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
	<row entidad="TIINVENTARIOACONT                       " atributo="FECHATRANSFERENCIA                      " tabla="TIINVCONT      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha transferencia                                                                                                                                             " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="FECHAIMPO                               " tabla="TIINVCONT      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="FECHAMODIFICACIONFW                     " tabla="TIINVCONT      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="FECHAEXPO                               " tabla="TIINVCONT      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="CODIGO                                  " tabla="TIINVCONT      " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="1" etiqueta="Número                                                                                                                                                          " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="TIINVCONT      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="ESTADOTRANSFERENCIA                     " tabla="TIINVCONT      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado transferencia                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="HORAALTAFW                              " tabla="TIINVCONT      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="HORAEXPO                                " tabla="TIINVCONT      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="BASEDEDATOSALTAFW                       " tabla="TIINVCONT      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="HORAIMPO                                " tabla="TIINVCONT      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="VERSIONMODIFICACIONFW                   " tabla="TIINVCONT      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="ZADSFW                                  " tabla="TIINVCONT      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="VERSIONALTAFW                           " tabla="TIINVCONT      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="USUARIOMODIFICACIONFW                   " tabla="TIINVCONT      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="HORAMODIFICACIONFW                      " tabla="TIINVCONT      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="SERIEALTAFW                             " tabla="TIINVCONT      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="SERIEMODIFICACIONFW                     " tabla="TIINVCONT      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="USUARIOALTAFW                           " tabla="TIINVCONT      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="DESCRIPCION                             " tabla="TIINVCONT      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="FECHAALTAFW                             " tabla="TIINVCONT      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=golibrerias.obtenerfecha()                                                                                                                                                                                                                                   " obligatorio="false" admitebusqueda="200" etiqueta="Fecha                                                                                                                                                           " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="FECHADESDE                              " tabla="TIINVCONT      " campo="FECHAD    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="201" etiqueta="Fecha                                                                                                                                                           " dominio="EtiquetaFechaDesdeHasta       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="FECHAHASTA                              " tabla="TIINVCONT      " campo="FECHAH    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=golibrerias.obtenerfecha()                                                                                                                                                                                                                                   " obligatorio="false" admitebusqueda="3" etiqueta="Fecha                                                                                                                                                           " dominio="EtiquetaFechaDesdeHasta       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="ARTICULODESDE                           " tabla="TIINVCONT      " campo="ARTDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="202" etiqueta="Artículo                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="ARTICULOHASTA                           " tabla="TIINVCONT      " campo="ARTHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="ZZZZZZZZZZZZZ                                                                                                                                                                                                                                                 " obligatorio="false" admitebusqueda="203" etiqueta="Artículo                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="COLORDESDE                              " tabla="TIINVCONT      " campo="COLDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="204" etiqueta="Color                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="COLORHASTA                              " tabla="TIINVCONT      " campo="COLHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="2" decimales="0" valorsugerido="ZZ                                                                                                                                                                                                                                                            " obligatorio="false" admitebusqueda="205" etiqueta="Color                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="TALLEDESDE                              " tabla="TIINVCONT      " campo="TALDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="206" etiqueta="Talle                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="TALLEHASTA                              " tabla="TIINVCONT      " campo="TALHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="ZZZ                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="207" etiqueta="Talle                                                                                                                                                           " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="PROVEEDORDESDE                          " tabla="TIINVCONT      " campo="PROVDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="208" etiqueta="Proveedor                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="7" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="PROVEEDORHASTA                          " tabla="TIINVCONT      " campo="PROVHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZ                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="209" etiqueta="Proveedor                                                                                                                                                       " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="7" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="UNIDADDEMEDIDADESDE                     " tabla="TIINVCONT      " campo="UNMEDDESDE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="210" etiqueta="Unidad de medida                                                                                                                                                " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="9" orden="16" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="UNIDADDEMEDIDAHASTA                     " tabla="TIINVCONT      " campo="UNMEDHASTA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="3" decimales="0" valorsugerido="ZZZ                                                                                                                                                                                                                                                           " obligatorio="false" admitebusqueda="211" etiqueta="Unidad de medida                                                                                                                                                " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="9" orden="17" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="MATERIALDESDE                           " tabla="TIINVCONT      " campo="MATDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="212" etiqueta="Material                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="11" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="MATERIALHASTA                           " tabla="TIINVCONT      " campo="MATHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="213" etiqueta="Material                                                                                                                                                        " dominio="EtiquetaCaracterDesdeHasta    " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="11" orden="21" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="OBS                                     " tabla="TIINVCONT      " campo="MOBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="214" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="15" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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