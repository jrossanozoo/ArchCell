
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
			local  lxTiinvcontFmodifw, lxTiinvcontFectrans, lxTiinvcontFecimpo, lxTiinvcontFecexpo, lxTiinvcontCodigo, lxTiinvcontHaltafw, lxTiinvcontHoraexpo, lxTiinvcontHoraimpo, lxTiinvcontBdaltafw, lxTiinvcontEsttrans, lxTiinvcontBdmodifw, lxTiinvcontSaltafw, lxTiinvcontHmodifw, lxTiinvcontVmodifw, lxTiinvcontZadsfw, lxTiinvcontValtafw, lxTiinvcontUmodifw, lxTiinvcontUaltafw, lxTiinvcontSmodifw, lxTiinvcontDescrip, lxTiinvcontFaltafw, lxTiinvcontFechad, lxTiinvcontFechah, lxTiinvcontArtdesde, lxTiinvcontArthasta, lxTiinvcontColdesde, lxTiinvcontColhasta, lxTiinvcontTaldesde, lxTiinvcontTalhasta, lxTiinvcontProvdesde, lxTiinvcontProvhasta, lxTiinvcontMatdesde, lxTiinvcontMathasta, lxTiinvcontTempdesde, lxTiinvcontTemphasta, lxTiinvcontFamdesde, lxTiinvcontFamhasta, lxTiinvcontGrupodesde, lxTiinvcontGrupohasta, lxTiinvcontLineadesde, lxTiinvcontLineahasta, lxTiinvcontCategdesde, lxTiinvcontCateghasta, lxTiinvcontClasdesde, lxTiinvcontClashasta, lxTiinvcontTipodesde, lxTiinvcontTipohasta, lxTiinvcontMobs
				lxTiinvcontFmodifw =  .Fechamodificacionfw			lxTiinvcontFectrans =  .Fechatransferencia			lxTiinvcontFecimpo =  .Fechaimpo			lxTiinvcontFecexpo =  .Fechaexpo			lxTiinvcontCodigo =  .Codigo			lxTiinvcontHaltafw =  .Horaaltafw			lxTiinvcontHoraexpo =  .Horaexpo			lxTiinvcontHoraimpo =  .Horaimpo			lxTiinvcontBdaltafw =  .Basededatosaltafw			lxTiinvcontEsttrans =  .Estadotransferencia			lxTiinvcontBdmodifw =  .Basededatosmodificacionfw			lxTiinvcontSaltafw =  .Seriealtafw			lxTiinvcontHmodifw =  .Horamodificacionfw			lxTiinvcontVmodifw =  .Versionmodificacionfw			lxTiinvcontZadsfw =  .Zadsfw			lxTiinvcontValtafw =  .Versionaltafw			lxTiinvcontUmodifw =  .Usuariomodificacionfw			lxTiinvcontUaltafw =  .Usuarioaltafw			lxTiinvcontSmodifw =  .Seriemodificacionfw			lxTiinvcontDescrip =  .Descripcion			lxTiinvcontFaltafw =  .Fechaaltafw			lxTiinvcontFechad =  .Fechadesde			lxTiinvcontFechah =  .Fechahasta			lxTiinvcontArtdesde =  upper( .ArticuloDesde_PK ) 			lxTiinvcontArthasta =  upper( .ArticuloHasta_PK ) 			lxTiinvcontColdesde =  upper( .ColorDesde_PK ) 			lxTiinvcontColhasta =  upper( .ColorHasta_PK ) 			lxTiinvcontTaldesde =  upper( .TalleDesde_PK ) 			lxTiinvcontTalhasta =  upper( .TalleHasta_PK ) 			lxTiinvcontProvdesde =  upper( .ProveedorDesde_PK ) 			lxTiinvcontProvhasta =  upper( .ProveedorHasta_PK ) 			lxTiinvcontMatdesde =  upper( .MaterialDesde_PK ) 			lxTiinvcontMathasta =  upper( .MaterialHasta_PK ) 			lxTiinvcontTempdesde =  upper( .TemporadaDesde_PK ) 			lxTiinvcontTemphasta =  upper( .TemporadaHasta_PK ) 			lxTiinvcontFamdesde =  upper( .FamiliaDesde_PK ) 			lxTiinvcontFamhasta =  upper( .FamiliaHasta_PK ) 			lxTiinvcontGrupodesde =  upper( .GrupoDesde_PK ) 			lxTiinvcontGrupohasta =  upper( .GrupoHasta_PK ) 			lxTiinvcontLineadesde =  upper( .LineaDesde_PK ) 			lxTiinvcontLineahasta =  upper( .LineaHasta_PK ) 			lxTiinvcontCategdesde =  upper( .CategoriaDeArticuloDesde_PK ) 			lxTiinvcontCateghasta =  upper( .CategoriaDeArticuloHasta_PK ) 			lxTiinvcontClasdesde =  upper( .ClasificacionDesde_PK ) 			lxTiinvcontClashasta =  upper( .ClasificacionHasta_PK ) 			lxTiinvcontTipodesde =  upper( .TipoDeArticuloDesde_PK ) 			lxTiinvcontTipohasta =  upper( .TipoDeArticuloHasta_PK ) 			lxTiinvcontMobs =  .Obs
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
				insert into ZooLogic.TIINVCONT ( "Fmodifw","Fectrans","Fecimpo","Fecexpo","Codigo","Haltafw","Horaexpo","Horaimpo","Bdaltafw","Esttrans","Bdmodifw","Saltafw","Hmodifw","Vmodifw","Zadsfw","Valtafw","Umodifw","Ualtafw","Smodifw","Descrip","Faltafw","Fechad","Fechah","Artdesde","Arthasta","Coldesde","Colhasta","Taldesde","Talhasta","Provdesde","Provhasta","Matdesde","Mathasta","Tempdesde","Temphasta","Famdesde","Famhasta","Grupodesde","Grupohasta","Lineadesde","Lineahasta","Categdesde","Categhasta","Clasdesde","Clashasta","Tipodesde","Tipohasta","Mobs" ) values ( <<"'" + this.ConvertirDateSql( lxTiinvcontFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvcontFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvcontFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvcontFecexpo ) + "'" >>, <<lxTiinvcontCodigo >>, <<"'" + this.FormatearTextoSql( lxTiinvcontHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontDescrip ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvcontFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvcontFechad ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvcontFechah ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontArtdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontArthasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontColdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontColhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontTaldesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontTalhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontProvdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontProvhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontMatdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontMathasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontTempdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontTemphasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontFamdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontFamhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontGrupodesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontGrupohasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontLineadesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontLineahasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontCategdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontCateghasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontClasdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontClashasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontTipodesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontTipohasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontMobs ) + "'" >> )
			endtext
			this.oConexion.EjecutarSql( lcSentencia  + goServicios.RealTime.ObtenerTagEstimulo( .oEntidad.cNombre ) )
		this.ComprobarTransaccion()
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = lxValorClavePrimaria

			dodefault()
			local lxArticuloDesde, lxArticuloHasta, lxColorDesde, lxColorHasta, lxTalleDesde, lxTalleHasta, lxFechaHasta, lxFechaAltaFW, lxCodigo, lxProveedorDesde, lxProveedorHasta, lxMaterialDesde, lxMaterialHasta, lxTemporadaDesde, lxTemporadaHasta, lxFamiliaDesde, lxFamiliaHasta, lxGrupoDesde, lxGrupoHasta, lxLineaDesde, lxLineaHasta, lxCategoriaDeArticuloDesde, lxCategoriaDeArticuloHasta, lxClasificacionDesde, lxClasificacionHasta, lxTipoDeArticuloDesde, lxTipoDeArticuloHasta
			if empty( this.oEntidad.ArticuloDesde_pk )
				lxArticuloDesde = null
			else
				lxArticuloDesde = this.oEntidad.ArticuloDesde_pk
			endif
			if this.oEntidad.ArticuloHasta_pk = [ZZZZZZZZZZZZZZZ]
				lxArticuloHasta = null
			else
				lxArticuloHasta = this.oEntidad.ArticuloHasta_pk
			endif
			if empty( this.oEntidad.ColorDesde_pk )
				lxColorDesde = null
			else
				lxColorDesde = this.oEntidad.ColorDesde_pk
			endif
			if this.oEntidad.ColorHasta_pk = [ZZZZZZ]
				lxColorHasta = null
			else
				lxColorHasta = this.oEntidad.ColorHasta_pk
			endif
			if empty( this.oEntidad.TalleDesde_pk )
				lxTalleDesde = null
			else
				lxTalleDesde = this.oEntidad.TalleDesde_pk
			endif
			if this.oEntidad.TalleHasta_pk = [ZZZZZ]
				lxTalleHasta = null
			else
				lxTalleHasta = this.oEntidad.TalleHasta_pk
			endif
			lxFechaHasta = this.oEntidad.FechaHasta
			lxFechaAltaFW = this.oEntidad.FechaAltaFW
			if empty( this.oEntidad.Codigo )
				lxCodigo = null
			else
				lxCodigo = this.oEntidad.Codigo
			endif
			if empty( this.oEntidad.ProveedorDesde_pk )
				lxProveedorDesde = null
			else
				lxProveedorDesde = this.oEntidad.ProveedorDesde_pk
			endif
			if this.oEntidad.ProveedorHasta_pk = [ZZZZZ]
				lxProveedorHasta = null
			else
				lxProveedorHasta = this.oEntidad.ProveedorHasta_pk
			endif
			if empty( this.oEntidad.MaterialDesde_pk )
				lxMaterialDesde = null
			else
				lxMaterialDesde = this.oEntidad.MaterialDesde_pk
			endif
			if this.oEntidad.MaterialHasta_pk = [ZZZZZZZZZZ]
				lxMaterialHasta = null
			else
				lxMaterialHasta = this.oEntidad.MaterialHasta_pk
			endif
			if empty( this.oEntidad.TemporadaDesde_pk )
				lxTemporadaDesde = null
			else
				lxTemporadaDesde = this.oEntidad.TemporadaDesde_pk
			endif
			if this.oEntidad.TemporadaHasta_pk = [ZZZZZ]
				lxTemporadaHasta = null
			else
				lxTemporadaHasta = this.oEntidad.TemporadaHasta_pk
			endif
			if empty( this.oEntidad.FamiliaDesde_pk )
				lxFamiliaDesde = null
			else
				lxFamiliaDesde = this.oEntidad.FamiliaDesde_pk
			endif
			if this.oEntidad.FamiliaHasta_pk = [ZZZZZZZZZZ]
				lxFamiliaHasta = null
			else
				lxFamiliaHasta = this.oEntidad.FamiliaHasta_pk
			endif
			if empty( this.oEntidad.GrupoDesde_pk )
				lxGrupoDesde = null
			else
				lxGrupoDesde = this.oEntidad.GrupoDesde_pk
			endif
			if this.oEntidad.GrupoHasta_pk = [ZZZZZZZZZZ]
				lxGrupoHasta = null
			else
				lxGrupoHasta = this.oEntidad.GrupoHasta_pk
			endif
			if empty( this.oEntidad.LineaDesde_pk )
				lxLineaDesde = null
			else
				lxLineaDesde = this.oEntidad.LineaDesde_pk
			endif
			if this.oEntidad.LineaHasta_pk = [ZZZZZZZZZZ]
				lxLineaHasta = null
			else
				lxLineaHasta = this.oEntidad.LineaHasta_pk
			endif
			if empty( this.oEntidad.CategoriaDeArticuloDesde_pk )
				lxCategoriaDeArticuloDesde = null
			else
				lxCategoriaDeArticuloDesde = this.oEntidad.CategoriaDeArticuloDesde_pk
			endif
			if this.oEntidad.CategoriaDeArticuloHasta_pk = [ZZZZZZZZZZ]
				lxCategoriaDeArticuloHasta = null
			else
				lxCategoriaDeArticuloHasta = this.oEntidad.CategoriaDeArticuloHasta_pk
			endif
			if empty( this.oEntidad.ClasificacionDesde_pk )
				lxClasificacionDesde = null
			else
				lxClasificacionDesde = this.oEntidad.ClasificacionDesde_pk
			endif
			if this.oEntidad.ClasificacionHasta_pk = [ZZZZZZZZZZ]
				lxClasificacionHasta = null
			else
				lxClasificacionHasta = this.oEntidad.ClasificacionHasta_pk
			endif
			if empty( this.oEntidad.TipoDeArticuloDesde_pk )
				lxTipoDeArticuloDesde = null
			else
				lxTipoDeArticuloDesde = this.oEntidad.TipoDeArticuloDesde_pk
			endif
			if this.oEntidad.TipoDeArticuloHasta_pk = [ZZZZZZZZZZ]
				lxTipoDeArticuloHasta = null
			else
				lxTipoDeArticuloHasta = this.oEntidad.TipoDeArticuloHasta_pk
			endif
			this.oSP.InsertarDesdeOtraEntidad(lxArticuloDesde, lxArticuloHasta, lxColorDesde, lxColorHasta, lxTalleDesde, lxTalleHasta, lxFechaHasta, lxFechaAltaFW, lxCodigo, lxProveedorDesde, lxProveedorHasta, lxMaterialDesde, lxMaterialHasta, lxTemporadaDesde, lxTemporadaHasta, lxFamiliaDesde, lxFamiliaHasta, lxGrupoDesde, lxGrupoHasta, lxLineaDesde, lxLineaHasta, lxCategoriaDeArticuloDesde, lxCategoriaDeArticuloHasta, lxClasificacionDesde, lxClasificacionHasta, lxTipoDeArticuloDesde, lxTipoDeArticuloHasta)
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
			local  lxTiinvcontFmodifw, lxTiinvcontFectrans, lxTiinvcontFecimpo, lxTiinvcontFecexpo, lxTiinvcontCodigo, lxTiinvcontHaltafw, lxTiinvcontHoraexpo, lxTiinvcontHoraimpo, lxTiinvcontBdaltafw, lxTiinvcontEsttrans, lxTiinvcontBdmodifw, lxTiinvcontSaltafw, lxTiinvcontHmodifw, lxTiinvcontVmodifw, lxTiinvcontZadsfw, lxTiinvcontValtafw, lxTiinvcontUmodifw, lxTiinvcontUaltafw, lxTiinvcontSmodifw, lxTiinvcontDescrip, lxTiinvcontFaltafw, lxTiinvcontFechad, lxTiinvcontFechah, lxTiinvcontArtdesde, lxTiinvcontArthasta, lxTiinvcontColdesde, lxTiinvcontColhasta, lxTiinvcontTaldesde, lxTiinvcontTalhasta, lxTiinvcontProvdesde, lxTiinvcontProvhasta, lxTiinvcontMatdesde, lxTiinvcontMathasta, lxTiinvcontTempdesde, lxTiinvcontTemphasta, lxTiinvcontFamdesde, lxTiinvcontFamhasta, lxTiinvcontGrupodesde, lxTiinvcontGrupohasta, lxTiinvcontLineadesde, lxTiinvcontLineahasta, lxTiinvcontCategdesde, lxTiinvcontCateghasta, lxTiinvcontClasdesde, lxTiinvcontClashasta, lxTiinvcontTipodesde, lxTiinvcontTipohasta, lxTiinvcontMobs
				lxTiinvcontFmodifw =  .Fechamodificacionfw			lxTiinvcontFectrans =  .Fechatransferencia			lxTiinvcontFecimpo =  .Fechaimpo			lxTiinvcontFecexpo =  .Fechaexpo			lxTiinvcontCodigo =  .Codigo			lxTiinvcontHaltafw =  .Horaaltafw			lxTiinvcontHoraexpo =  .Horaexpo			lxTiinvcontHoraimpo =  .Horaimpo			lxTiinvcontBdaltafw =  .Basededatosaltafw			lxTiinvcontEsttrans =  .Estadotransferencia			lxTiinvcontBdmodifw =  .Basededatosmodificacionfw			lxTiinvcontSaltafw =  .Seriealtafw			lxTiinvcontHmodifw =  .Horamodificacionfw			lxTiinvcontVmodifw =  .Versionmodificacionfw			lxTiinvcontZadsfw =  .Zadsfw			lxTiinvcontValtafw =  .Versionaltafw			lxTiinvcontUmodifw =  .Usuariomodificacionfw			lxTiinvcontUaltafw =  .Usuarioaltafw			lxTiinvcontSmodifw =  .Seriemodificacionfw			lxTiinvcontDescrip =  .Descripcion			lxTiinvcontFaltafw =  .Fechaaltafw			lxTiinvcontFechad =  .Fechadesde			lxTiinvcontFechah =  .Fechahasta			lxTiinvcontArtdesde =  upper( .ArticuloDesde_PK ) 			lxTiinvcontArthasta =  upper( .ArticuloHasta_PK ) 			lxTiinvcontColdesde =  upper( .ColorDesde_PK ) 			lxTiinvcontColhasta =  upper( .ColorHasta_PK ) 			lxTiinvcontTaldesde =  upper( .TalleDesde_PK ) 			lxTiinvcontTalhasta =  upper( .TalleHasta_PK ) 			lxTiinvcontProvdesde =  upper( .ProveedorDesde_PK ) 			lxTiinvcontProvhasta =  upper( .ProveedorHasta_PK ) 			lxTiinvcontMatdesde =  upper( .MaterialDesde_PK ) 			lxTiinvcontMathasta =  upper( .MaterialHasta_PK ) 			lxTiinvcontTempdesde =  upper( .TemporadaDesde_PK ) 			lxTiinvcontTemphasta =  upper( .TemporadaHasta_PK ) 			lxTiinvcontFamdesde =  upper( .FamiliaDesde_PK ) 			lxTiinvcontFamhasta =  upper( .FamiliaHasta_PK ) 			lxTiinvcontGrupodesde =  upper( .GrupoDesde_PK ) 			lxTiinvcontGrupohasta =  upper( .GrupoHasta_PK ) 			lxTiinvcontLineadesde =  upper( .LineaDesde_PK ) 			lxTiinvcontLineahasta =  upper( .LineaHasta_PK ) 			lxTiinvcontCategdesde =  upper( .CategoriaDeArticuloDesde_PK ) 			lxTiinvcontCateghasta =  upper( .CategoriaDeArticuloHasta_PK ) 			lxTiinvcontClasdesde =  upper( .ClasificacionDesde_PK ) 			lxTiinvcontClashasta =  upper( .ClasificacionHasta_PK ) 			lxTiinvcontTipodesde =  upper( .TipoDeArticuloDesde_PK ) 			lxTiinvcontTipohasta =  upper( .TipoDeArticuloHasta_PK ) 			lxTiinvcontMobs =  .Obs
		endwith
		
		with this
		Try
			this.SetearConexionParaTransaccion()
			this.oConexion.EjecutarSql( 'BEGIN TRANSACTION' )
			this.DespuesBeginTransaction()
			lxValorClavePrimaria = .oEntidad.CODIGO
			local lcSentencia as string

			text to lcSentencia textmerge noshow
				update ZooLogic.TIINVCONT set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxTiinvcontFmodifw ) + "'">>,"Fectrans" = <<"'" + this.ConvertirDateSql( lxTiinvcontFectrans ) + "'">>,"Fecimpo" = <<"'" + this.ConvertirDateSql( lxTiinvcontFecimpo ) + "'">>,"Fecexpo" = <<"'" + this.ConvertirDateSql( lxTiinvcontFecexpo ) + "'">>,"Codigo" = <<lxTiinvcontCodigo>>,"Haltafw" = <<"'" + this.FormatearTextoSql( lxTiinvcontHaltafw ) + "'">>,"Horaexpo" = <<"'" + this.FormatearTextoSql( lxTiinvcontHoraexpo ) + "'">>,"Horaimpo" = <<"'" + this.FormatearTextoSql( lxTiinvcontHoraimpo ) + "'">>,"Bdaltafw" = <<"'" + this.FormatearTextoSql( lxTiinvcontBdaltafw ) + "'">>,"Esttrans" = <<"'" + this.FormatearTextoSql( lxTiinvcontEsttrans ) + "'">>,"Bdmodifw" = <<"'" + this.FormatearTextoSql( lxTiinvcontBdmodifw ) + "'">>,"Saltafw" = <<"'" + this.FormatearTextoSql( lxTiinvcontSaltafw ) + "'">>,"Hmodifw" = <<"'" + this.FormatearTextoSql( lxTiinvcontHmodifw ) + "'">>,"Vmodifw" = <<"'" + this.FormatearTextoSql( lxTiinvcontVmodifw ) + "'">>,"Zadsfw" = <<"'" + this.FormatearTextoSql( lxTiinvcontZadsfw ) + "'">>,"Valtafw" = <<"'" + this.FormatearTextoSql( lxTiinvcontValtafw ) + "'">>,"Umodifw" = <<"'" + this.FormatearTextoSql( lxTiinvcontUmodifw ) + "'">>,"Ualtafw" = <<"'" + this.FormatearTextoSql( lxTiinvcontUaltafw ) + "'">>,"Smodifw" = <<"'" + this.FormatearTextoSql( lxTiinvcontSmodifw ) + "'">>,"Descrip" = <<"'" + this.FormatearTextoSql( lxTiinvcontDescrip ) + "'">>,"Faltafw" = <<"'" + this.ConvertirDateSql( lxTiinvcontFaltafw ) + "'">>,"Fechad" = <<"'" + this.ConvertirDateSql( lxTiinvcontFechad ) + "'">>,"Fechah" = <<"'" + this.ConvertirDateSql( lxTiinvcontFechah ) + "'">>,"Artdesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontArtdesde ) + "'">>,"Arthasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontArthasta ) + "'">>,"Coldesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontColdesde ) + "'">>,"Colhasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontColhasta ) + "'">>,"Taldesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontTaldesde ) + "'">>,"Talhasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontTalhasta ) + "'">>,"Provdesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontProvdesde ) + "'">>,"Provhasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontProvhasta ) + "'">>,"Matdesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontMatdesde ) + "'">>,"Mathasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontMathasta ) + "'">>,"Tempdesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontTempdesde ) + "'">>,"Temphasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontTemphasta ) + "'">>,"Famdesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontFamdesde ) + "'">>,"Famhasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontFamhasta ) + "'">>,"Grupodesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontGrupodesde ) + "'">>,"Grupohasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontGrupohasta ) + "'">>,"Lineadesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontLineadesde ) + "'">>,"Lineahasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontLineahasta ) + "'">>,"Categdesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontCategdesde ) + "'">>,"Categhasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontCateghasta ) + "'">>,"Clasdesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontClasdesde ) + "'">>,"Clashasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontClashasta ) + "'">>,"Tipodesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontTipodesde ) + "'">>,"Tipohasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontTipohasta ) + "'">>,"Mobs" = <<"'" + this.FormatearTextoSql( lxTiinvcontMobs ) + "'">> where "Codigo" = <<lxTiinvcontCodigo>> and  TIINVCONT.CODIGO != 0 << this.oEntidad.ObtenerWhereAdicionalParaSentenciaUpdate() >>
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
				select "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Codigo" as "Codigo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Descrip" as "Descripcion", "Faltafw" as "Fechaaltafw", "Fechad" as "Fechadesde", "Fechah" as "Fechahasta", "Artdesde" as "Articulodesde", "Arthasta" as "Articulohasta", "Coldesde" as "Colordesde", "Colhasta" as "Colorhasta", "Taldesde" as "Talledesde", "Talhasta" as "Tallehasta", "Provdesde" as "Proveedordesde", "Provhasta" as "Proveedorhasta", "Matdesde" as "Materialdesde", "Mathasta" as "Materialhasta", "Tempdesde" as "Temporadadesde", "Temphasta" as "Temporadahasta", "Famdesde" as "Familiadesde", "Famhasta" as "Familiahasta", "Grupodesde" as "Grupodesde", "Grupohasta" as "Grupohasta", "Lineadesde" as "Lineadesde", "Lineahasta" as "Lineahasta", "Categdesde" as "Categoriadearticulodesde", "Categhasta" as "Categoriadearticulohasta", "Clasdesde" as "Clasificaciondesde", "Clashasta" as "Clasificacionhasta", "Tipodesde" as "Tipodearticulodesde", "Tipohasta" as "Tipodearticulohasta", "Mobs" as "Obs" from ZooLogic.TIINVCONT where "Codigo" = <<lxTiinvcontCodigo>> and  TIINVCONT.CODIGO != 0
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Codigo" as "Codigo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Descrip" as "Descripcion", "Faltafw" as "Fechaaltafw", "Fechad" as "Fechadesde", "Fechah" as "Fechahasta", "Artdesde" as "Articulodesde", "Arthasta" as "Articulohasta", "Coldesde" as "Colordesde", "Colhasta" as "Colorhasta", "Taldesde" as "Talledesde", "Talhasta" as "Tallehasta", "Provdesde" as "Proveedordesde", "Provhasta" as "Proveedorhasta", "Matdesde" as "Materialdesde", "Mathasta" as "Materialhasta", "Tempdesde" as "Temporadadesde", "Temphasta" as "Temporadahasta", "Famdesde" as "Familiadesde", "Famhasta" as "Familiahasta", "Grupodesde" as "Grupodesde", "Grupohasta" as "Grupohasta", "Lineadesde" as "Lineadesde", "Lineahasta" as "Lineahasta", "Categdesde" as "Categoriadearticulodesde", "Categhasta" as "Categoriadearticulohasta", "Clasdesde" as "Clasificaciondesde", "Clashasta" as "Clasificacionhasta", "Tipodesde" as "Tipodearticulodesde", "Tipohasta" as "Tipodearticulohasta", "Mobs" as "Obs" from ZooLogic.TIINVCONT where  TIINVCONT.CODIGO != 0 order by CODIGO
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Codigo" as "Codigo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Descrip" as "Descripcion", "Faltafw" as "Fechaaltafw", "Fechad" as "Fechadesde", "Fechah" as "Fechahasta", "Artdesde" as "Articulodesde", "Arthasta" as "Articulohasta", "Coldesde" as "Colordesde", "Colhasta" as "Colorhasta", "Taldesde" as "Talledesde", "Talhasta" as "Tallehasta", "Provdesde" as "Proveedordesde", "Provhasta" as "Proveedorhasta", "Matdesde" as "Materialdesde", "Mathasta" as "Materialhasta", "Tempdesde" as "Temporadadesde", "Temphasta" as "Temporadahasta", "Famdesde" as "Familiadesde", "Famhasta" as "Familiahasta", "Grupodesde" as "Grupodesde", "Grupohasta" as "Grupohasta", "Lineadesde" as "Lineadesde", "Lineahasta" as "Lineahasta", "Categdesde" as "Categoriadearticulodesde", "Categhasta" as "Categoriadearticulohasta", "Clasdesde" as "Clasificaciondesde", "Clashasta" as "Clasificacionhasta", "Tipodesde" as "Tipodearticulodesde", "Tipohasta" as "Tipodearticulohasta", "Mobs" as "Obs" from ZooLogic.TIINVCONT where  str( CODIGO, 8, 0) > <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  TIINVCONT.CODIGO != 0 order by CODIGO
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Codigo" as "Codigo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Descrip" as "Descripcion", "Faltafw" as "Fechaaltafw", "Fechad" as "Fechadesde", "Fechah" as "Fechahasta", "Artdesde" as "Articulodesde", "Arthasta" as "Articulohasta", "Coldesde" as "Colordesde", "Colhasta" as "Colorhasta", "Taldesde" as "Talledesde", "Talhasta" as "Tallehasta", "Provdesde" as "Proveedordesde", "Provhasta" as "Proveedorhasta", "Matdesde" as "Materialdesde", "Mathasta" as "Materialhasta", "Tempdesde" as "Temporadadesde", "Temphasta" as "Temporadahasta", "Famdesde" as "Familiadesde", "Famhasta" as "Familiahasta", "Grupodesde" as "Grupodesde", "Grupohasta" as "Grupohasta", "Lineadesde" as "Lineadesde", "Lineahasta" as "Lineahasta", "Categdesde" as "Categoriadearticulodesde", "Categhasta" as "Categoriadearticulohasta", "Clasdesde" as "Clasificaciondesde", "Clashasta" as "Clasificacionhasta", "Tipodesde" as "Tipodearticulodesde", "Tipohasta" as "Tipodearticulohasta", "Mobs" as "Obs" from ZooLogic.TIINVCONT where  str( CODIGO, 8, 0) < <<"'" + this.FormatearTextoSql( lcOrden ) + "'">> and  TIINVCONT.CODIGO != 0 order by CODIGO desc
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
				select top 1 "Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Codigo" as "Codigo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Descrip" as "Descripcion", "Faltafw" as "Fechaaltafw", "Fechad" as "Fechadesde", "Fechah" as "Fechahasta", "Artdesde" as "Articulodesde", "Arthasta" as "Articulohasta", "Coldesde" as "Colordesde", "Colhasta" as "Colorhasta", "Taldesde" as "Talledesde", "Talhasta" as "Tallehasta", "Provdesde" as "Proveedordesde", "Provhasta" as "Proveedorhasta", "Matdesde" as "Materialdesde", "Mathasta" as "Materialhasta", "Tempdesde" as "Temporadadesde", "Temphasta" as "Temporadahasta", "Famdesde" as "Familiadesde", "Famhasta" as "Familiahasta", "Grupodesde" as "Grupodesde", "Grupohasta" as "Grupohasta", "Lineadesde" as "Lineadesde", "Lineahasta" as "Lineahasta", "Categdesde" as "Categoriadearticulodesde", "Categhasta" as "Categoriadearticulohasta", "Clasdesde" as "Clasificaciondesde", "Clashasta" as "Clasificacionhasta", "Tipodesde" as "Tipodearticulodesde", "Tipohasta" as "Tipodearticulohasta", "Mobs" as "Obs" from ZooLogic.TIINVCONT where  TIINVCONT.CODIGO != 0 order by CODIGO desc
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
			lcXml = this.oConexion.EjecutarSql( "select Fmodifw,Fectrans,Fecimpo,Fecexpo,Codigo,Haltafw,Horaexpo,Horaimpo,Bdaltafw,Esttrans,Bdmodifw" + ;
",Saltafw,Hmodifw,Vmodifw,Zadsfw,Valtafw,Umodifw,Ualtafw,Smodifw,Descrip,Faltafw,Fechad,Fechah,Artdes" + ;
"de,Arthasta,Coldesde,Colhasta,Taldesde,Talhasta,Provdesde,Provhasta,Matdesde,Mathasta,Tempdesde,Temp" + ;
"hasta,Famdesde,Famhasta,Grupodesde,Grupohasta,Lineadesde,Lineahasta,Categdesde,Categhasta,Clasdesde," + ;
"Clashasta,Tipodesde,Tipohasta,Mobs" + ;
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
			local  lxTiinvcontFmodifw, lxTiinvcontFectrans, lxTiinvcontFecimpo, lxTiinvcontFecexpo, lxTiinvcontCodigo, lxTiinvcontHaltafw, lxTiinvcontHoraexpo, lxTiinvcontHoraimpo, lxTiinvcontBdaltafw, lxTiinvcontEsttrans, lxTiinvcontBdmodifw, lxTiinvcontSaltafw, lxTiinvcontHmodifw, lxTiinvcontVmodifw, lxTiinvcontZadsfw, lxTiinvcontValtafw, lxTiinvcontUmodifw, lxTiinvcontUaltafw, lxTiinvcontSmodifw, lxTiinvcontDescrip, lxTiinvcontFaltafw, lxTiinvcontFechad, lxTiinvcontFechah, lxTiinvcontArtdesde, lxTiinvcontArthasta, lxTiinvcontColdesde, lxTiinvcontColhasta, lxTiinvcontTaldesde, lxTiinvcontTalhasta, lxTiinvcontProvdesde, lxTiinvcontProvhasta, lxTiinvcontMatdesde, lxTiinvcontMathasta, lxTiinvcontTempdesde, lxTiinvcontTemphasta, lxTiinvcontFamdesde, lxTiinvcontFamhasta, lxTiinvcontGrupodesde, lxTiinvcontGrupohasta, lxTiinvcontLineadesde, lxTiinvcontLineahasta, lxTiinvcontCategdesde, lxTiinvcontCateghasta, lxTiinvcontClasdesde, lxTiinvcontClashasta, lxTiinvcontTipodesde, lxTiinvcontTipohasta, lxTiinvcontMobs
				lxTiinvcontFmodifw = ctod( '  /  /    ' )			lxTiinvcontFectrans = ctod( '  /  /    ' )			lxTiinvcontFecimpo = ctod( '  /  /    ' )			lxTiinvcontFecexpo = ctod( '  /  /    ' )			lxTiinvcontCodigo = 0			lxTiinvcontHaltafw = []			lxTiinvcontHoraexpo = []			lxTiinvcontHoraimpo = []			lxTiinvcontBdaltafw = []			lxTiinvcontEsttrans = []			lxTiinvcontBdmodifw = []			lxTiinvcontSaltafw = []			lxTiinvcontHmodifw = []			lxTiinvcontVmodifw = []			lxTiinvcontZadsfw = []			lxTiinvcontValtafw = []			lxTiinvcontUmodifw = []			lxTiinvcontUaltafw = []			lxTiinvcontSmodifw = []			lxTiinvcontDescrip = []			lxTiinvcontFaltafw = ctod( '  /  /    ' )			lxTiinvcontFechad = ctod( '  /  /    ' )			lxTiinvcontFechah = ctod( '  /  /    ' )			lxTiinvcontArtdesde = []			lxTiinvcontArthasta = []			lxTiinvcontColdesde = []			lxTiinvcontColhasta = []			lxTiinvcontTaldesde = []			lxTiinvcontTalhasta = []			lxTiinvcontProvdesde = []			lxTiinvcontProvhasta = []			lxTiinvcontMatdesde = []			lxTiinvcontMathasta = []			lxTiinvcontTempdesde = []			lxTiinvcontTemphasta = []			lxTiinvcontFamdesde = []			lxTiinvcontFamhasta = []			lxTiinvcontGrupodesde = []			lxTiinvcontGrupohasta = []			lxTiinvcontLineadesde = []			lxTiinvcontLineahasta = []			lxTiinvcontCategdesde = []			lxTiinvcontCateghasta = []			lxTiinvcontClasdesde = []			lxTiinvcontClashasta = []			lxTiinvcontTipodesde = []			lxTiinvcontTipohasta = []			lxTiinvcontMobs = []
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
					"Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Codigo" as "Codigo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Descrip" as "Descripcion", "Faltafw" as "Fechaaltafw", "Fechad" as "Fechadesde", "Fechah" as "Fechahasta", "Artdesde" as "Articulodesde", "Arthasta" as "Articulohasta", "Coldesde" as "Colordesde", "Colhasta" as "Colorhasta", "Taldesde" as "Talledesde", "Talhasta" as "Tallehasta", "Provdesde" as "Proveedordesde", "Provhasta" as "Proveedorhasta", "Matdesde" as "Materialdesde", "Mathasta" as "Materialhasta", "Tempdesde" as "Temporadadesde", "Temphasta" as "Temporadahasta", "Famdesde" as "Familiadesde", "Famhasta" as "Familiahasta", "Grupodesde" as "Grupodesde", "Grupohasta" as "Grupohasta", "Lineadesde" as "Lineadesde", "Lineahasta" as "Lineahasta", "Categdesde" as "Categoriadearticulodesde", "Categhasta" as "Categoriadearticulohasta", "Clasdesde" as "Clasificaciondesde", "Clashasta" as "Clasificacionhasta", "Tipodesde" as "Tipodearticulodesde", "Tipohasta" as "Tipodearticulohasta", "Mobs" as "Obs"
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
				Case lcAtributo == 'FECHAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FMODIFW AS FECHAMODIFICACIONFW'
				Case lcAtributo == 'FECHATRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECTRANS AS FECHATRANSFERENCIA'
				Case lcAtributo == 'FECHAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECIMPO AS FECHAIMPO'
				Case lcAtributo == 'FECHAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FECEXPO AS FECHAEXPO'
				Case lcAtributo == 'CODIGO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CODIGO AS CODIGO'
				Case lcAtributo == 'HORAALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HALTAFW AS HORAALTAFW'
				Case lcAtributo == 'HORAEXPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAEXPO AS HORAEXPO'
				Case lcAtributo == 'HORAIMPO'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HORAIMPO AS HORAIMPO'
				Case lcAtributo == 'BASEDEDATOSALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDALTAFW AS BASEDEDATOSALTAFW'
				Case lcAtributo == 'ESTADOTRANSFERENCIA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ESTTRANS AS ESTADOTRANSFERENCIA'
				Case lcAtributo == 'BASEDEDATOSMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'BDMODIFW AS BASEDEDATOSMODIFICACIONFW'
				Case lcAtributo == 'SERIEALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SALTAFW AS SERIEALTAFW'
				Case lcAtributo == 'HORAMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'HMODIFW AS HORAMODIFICACIONFW'
				Case lcAtributo == 'VERSIONMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VMODIFW AS VERSIONMODIFICACIONFW'
				Case lcAtributo == 'ZADSFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'ZADSFW AS ZADSFW'
				Case lcAtributo == 'VERSIONALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'VALTAFW AS VERSIONALTAFW'
				Case lcAtributo == 'USUARIOMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UMODIFW AS USUARIOMODIFICACIONFW'
				Case lcAtributo == 'USUARIOALTAFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'UALTAFW AS USUARIOALTAFW'
				Case lcAtributo == 'SERIEMODIFICACIONFW'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'SMODIFW AS SERIEMODIFICACIONFW'
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
				Case lcAtributo == 'MATERIALDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MATDESDE AS MATERIALDESDE'
				Case lcAtributo == 'MATERIALHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'MATHASTA AS MATERIALHASTA'
				Case lcAtributo == 'TEMPORADADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TEMPDESDE AS TEMPORADADESDE'
				Case lcAtributo == 'TEMPORADAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TEMPHASTA AS TEMPORADAHASTA'
				Case lcAtributo == 'FAMILIADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAMDESDE AS FAMILIADESDE'
				Case lcAtributo == 'FAMILIAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'FAMHASTA AS FAMILIAHASTA'
				Case lcAtributo == 'GRUPODESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GRUPODESDE AS GRUPODESDE'
				Case lcAtributo == 'GRUPOHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'GRUPOHASTA AS GRUPOHASTA'
				Case lcAtributo == 'LINEADESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LINEADESDE AS LINEADESDE'
				Case lcAtributo == 'LINEAHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'LINEAHASTA AS LINEAHASTA'
				Case lcAtributo == 'CATEGORIADEARTICULODESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CATEGDESDE AS CATEGORIADEARTICULODESDE'
				Case lcAtributo == 'CATEGORIADEARTICULOHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CATEGHASTA AS CATEGORIADEARTICULOHASTA'
				Case lcAtributo == 'CLASIFICACIONDESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLASDESDE AS CLASIFICACIONDESDE'
				Case lcAtributo == 'CLASIFICACIONHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'CLASHASTA AS CLASIFICACIONHASTA'
				Case lcAtributo == 'TIPODEARTICULODESDE'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPODESDE AS TIPODEARTICULODESDE'
				Case lcAtributo == 'TIPODEARTICULOHASTA'
					lcSelect = lcSelect + iif( Empty( lcSelect ),'', ',' ) + 'TIPOHASTA AS TIPODEARTICULOHASTA'
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
			Case upper( alltrim( tcAtributo ) ) == 'FECHAMODIFICACIONFW'
				lcCampo = 'FMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'FECHATRANSFERENCIA'
				lcCampo = 'FECTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAIMPO'
				lcCampo = 'FECIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'FECHAEXPO'
				lcCampo = 'FECEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'CODIGO'
				lcCampo = 'CODIGO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAALTAFW'
				lcCampo = 'HALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAEXPO'
				lcCampo = 'HORAEXPO'
			Case upper( alltrim( tcAtributo ) ) == 'HORAIMPO'
				lcCampo = 'HORAIMPO'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSALTAFW'
				lcCampo = 'BDALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'ESTADOTRANSFERENCIA'
				lcCampo = 'ESTTRANS'
			Case upper( alltrim( tcAtributo ) ) == 'BASEDEDATOSMODIFICACIONFW'
				lcCampo = 'BDMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEALTAFW'
				lcCampo = 'SALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'HORAMODIFICACIONFW'
				lcCampo = 'HMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONMODIFICACIONFW'
				lcCampo = 'VMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'ZADSFW'
				lcCampo = 'ZADSFW'
			Case upper( alltrim( tcAtributo ) ) == 'VERSIONALTAFW'
				lcCampo = 'VALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOMODIFICACIONFW'
				lcCampo = 'UMODIFW'
			Case upper( alltrim( tcAtributo ) ) == 'USUARIOALTAFW'
				lcCampo = 'UALTAFW'
			Case upper( alltrim( tcAtributo ) ) == 'SERIEMODIFICACIONFW'
				lcCampo = 'SMODIFW'
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
			Case upper( alltrim( tcAtributo ) ) == 'MATERIALDESDE'
				lcCampo = 'MATDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'MATERIALHASTA'
				lcCampo = 'MATHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'TEMPORADADESDE'
				lcCampo = 'TEMPDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'TEMPORADAHASTA'
				lcCampo = 'TEMPHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'FAMILIADESDE'
				lcCampo = 'FAMDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'FAMILIAHASTA'
				lcCampo = 'FAMHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'GRUPODESDE'
				lcCampo = 'GRUPODESDE'
			Case upper( alltrim( tcAtributo ) ) == 'GRUPOHASTA'
				lcCampo = 'GRUPOHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'LINEADESDE'
				lcCampo = 'LINEADESDE'
			Case upper( alltrim( tcAtributo ) ) == 'LINEAHASTA'
				lcCampo = 'LINEAHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'CATEGORIADEARTICULODESDE'
				lcCampo = 'CATEGDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'CATEGORIADEARTICULOHASTA'
				lcCampo = 'CATEGHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'CLASIFICACIONDESDE'
				lcCampo = 'CLASDESDE'
			Case upper( alltrim( tcAtributo ) ) == 'CLASIFICACIONHASTA'
				lcCampo = 'CLASHASTA'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODEARTICULODESDE'
				lcCampo = 'TIPODESDE'
			Case upper( alltrim( tcAtributo ) ) == 'TIPODEARTICULOHASTA'
				lcCampo = 'TIPOHASTA'
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
			local  lxTiinvcontFmodifw, lxTiinvcontFectrans, lxTiinvcontFecimpo, lxTiinvcontFecexpo, lxTiinvcontCodigo, lxTiinvcontHaltafw, lxTiinvcontHoraexpo, lxTiinvcontHoraimpo, lxTiinvcontBdaltafw, lxTiinvcontEsttrans, lxTiinvcontBdmodifw, lxTiinvcontSaltafw, lxTiinvcontHmodifw, lxTiinvcontVmodifw, lxTiinvcontZadsfw, lxTiinvcontValtafw, lxTiinvcontUmodifw, lxTiinvcontUaltafw, lxTiinvcontSmodifw, lxTiinvcontDescrip, lxTiinvcontFaltafw, lxTiinvcontFechad, lxTiinvcontFechah, lxTiinvcontArtdesde, lxTiinvcontArthasta, lxTiinvcontColdesde, lxTiinvcontColhasta, lxTiinvcontTaldesde, lxTiinvcontTalhasta, lxTiinvcontProvdesde, lxTiinvcontProvhasta, lxTiinvcontMatdesde, lxTiinvcontMathasta, lxTiinvcontTempdesde, lxTiinvcontTemphasta, lxTiinvcontFamdesde, lxTiinvcontFamhasta, lxTiinvcontGrupodesde, lxTiinvcontGrupohasta, lxTiinvcontLineadesde, lxTiinvcontLineahasta, lxTiinvcontCategdesde, lxTiinvcontCateghasta, lxTiinvcontClasdesde, lxTiinvcontClashasta, lxTiinvcontTipodesde, lxTiinvcontTipohasta, lxTiinvcontMobs
				lxTiinvcontFmodifw =  .Fechamodificacionfw			lxTiinvcontFectrans =  .Fechatransferencia			lxTiinvcontFecimpo =  .Fechaimpo			lxTiinvcontFecexpo =  .Fechaexpo			lxTiinvcontCodigo =  .Codigo			lxTiinvcontHaltafw =  .Horaaltafw			lxTiinvcontHoraexpo =  .Horaexpo			lxTiinvcontHoraimpo =  .Horaimpo			lxTiinvcontBdaltafw =  .Basededatosaltafw			lxTiinvcontEsttrans =  .Estadotransferencia			lxTiinvcontBdmodifw =  .Basededatosmodificacionfw			lxTiinvcontSaltafw =  .Seriealtafw			lxTiinvcontHmodifw =  .Horamodificacionfw			lxTiinvcontVmodifw =  .Versionmodificacionfw			lxTiinvcontZadsfw =  .Zadsfw			lxTiinvcontValtafw =  .Versionaltafw			lxTiinvcontUmodifw =  .Usuariomodificacionfw			lxTiinvcontUaltafw =  .Usuarioaltafw			lxTiinvcontSmodifw =  .Seriemodificacionfw			lxTiinvcontDescrip =  .Descripcion			lxTiinvcontFaltafw =  .Fechaaltafw			lxTiinvcontFechad =  .Fechadesde			lxTiinvcontFechah =  .Fechahasta			lxTiinvcontArtdesde =  upper( .ArticuloDesde_PK ) 			lxTiinvcontArthasta =  upper( .ArticuloHasta_PK ) 			lxTiinvcontColdesde =  upper( .ColorDesde_PK ) 			lxTiinvcontColhasta =  upper( .ColorHasta_PK ) 			lxTiinvcontTaldesde =  upper( .TalleDesde_PK ) 			lxTiinvcontTalhasta =  upper( .TalleHasta_PK ) 			lxTiinvcontProvdesde =  upper( .ProveedorDesde_PK ) 			lxTiinvcontProvhasta =  upper( .ProveedorHasta_PK ) 			lxTiinvcontMatdesde =  upper( .MaterialDesde_PK ) 			lxTiinvcontMathasta =  upper( .MaterialHasta_PK ) 			lxTiinvcontTempdesde =  upper( .TemporadaDesde_PK ) 			lxTiinvcontTemphasta =  upper( .TemporadaHasta_PK ) 			lxTiinvcontFamdesde =  upper( .FamiliaDesde_PK ) 			lxTiinvcontFamhasta =  upper( .FamiliaHasta_PK ) 			lxTiinvcontGrupodesde =  upper( .GrupoDesde_PK ) 			lxTiinvcontGrupohasta =  upper( .GrupoHasta_PK ) 			lxTiinvcontLineadesde =  upper( .LineaDesde_PK ) 			lxTiinvcontLineahasta =  upper( .LineaHasta_PK ) 			lxTiinvcontCategdesde =  upper( .CategoriaDeArticuloDesde_PK ) 			lxTiinvcontCateghasta =  upper( .CategoriaDeArticuloHasta_PK ) 			lxTiinvcontClasdesde =  upper( .ClasificacionDesde_PK ) 			lxTiinvcontClashasta =  upper( .ClasificacionHasta_PK ) 			lxTiinvcontTipodesde =  upper( .TipoDeArticuloDesde_PK ) 			lxTiinvcontTipohasta =  upper( .TipoDeArticuloHasta_PK ) 			lxTiinvcontMobs =  .Obs
		endwith
		text to lcSentencia noshow textmerge pretext 15
			insert into ZooLogic.TIINVCONT ( "Fmodifw","Fectrans","Fecimpo","Fecexpo","Codigo","Haltafw","Horaexpo","Horaimpo","Bdaltafw","Esttrans","Bdmodifw","Saltafw","Hmodifw","Vmodifw","Zadsfw","Valtafw","Umodifw","Ualtafw","Smodifw","Descrip","Faltafw","Fechad","Fechah","Artdesde","Arthasta","Coldesde","Colhasta","Taldesde","Talhasta","Provdesde","Provhasta","Matdesde","Mathasta","Tempdesde","Temphasta","Famdesde","Famhasta","Grupodesde","Grupohasta","Lineadesde","Lineahasta","Categdesde","Categhasta","Clasdesde","Clashasta","Tipodesde","Tipohasta","Mobs" ) values ( <<"'" + this.ConvertirDateSql( lxTiinvcontFmodifw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvcontFectrans ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvcontFecimpo ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvcontFecexpo ) + "'" >>, <<lxTiinvcontCodigo >>, <<"'" + this.FormatearTextoSql( lxTiinvcontHaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontHoraexpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontHoraimpo ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontBdaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontEsttrans ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontBdmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontSaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontHmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontVmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontZadsfw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontValtafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontUmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontUaltafw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontSmodifw ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontDescrip ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvcontFaltafw ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvcontFechad ) + "'" >>, <<"'" + this.ConvertirDateSql( lxTiinvcontFechah ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontArtdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontArthasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontColdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontColhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontTaldesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontTalhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontProvdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontProvhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontMatdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontMathasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontTempdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontTemphasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontFamdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontFamhasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontGrupodesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontGrupohasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontLineadesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontLineahasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontCategdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontCateghasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontClasdesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontClashasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontTipodesde ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontTipohasta ) + "'" >>, <<"'" + this.FormatearTextoSql( lxTiinvcontMobs ) + "'" >> )
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
			local  lxTiinvcontFmodifw, lxTiinvcontFectrans, lxTiinvcontFecimpo, lxTiinvcontFecexpo, lxTiinvcontCodigo, lxTiinvcontHaltafw, lxTiinvcontHoraexpo, lxTiinvcontHoraimpo, lxTiinvcontBdaltafw, lxTiinvcontEsttrans, lxTiinvcontBdmodifw, lxTiinvcontSaltafw, lxTiinvcontHmodifw, lxTiinvcontVmodifw, lxTiinvcontZadsfw, lxTiinvcontValtafw, lxTiinvcontUmodifw, lxTiinvcontUaltafw, lxTiinvcontSmodifw, lxTiinvcontDescrip, lxTiinvcontFaltafw, lxTiinvcontFechad, lxTiinvcontFechah, lxTiinvcontArtdesde, lxTiinvcontArthasta, lxTiinvcontColdesde, lxTiinvcontColhasta, lxTiinvcontTaldesde, lxTiinvcontTalhasta, lxTiinvcontProvdesde, lxTiinvcontProvhasta, lxTiinvcontMatdesde, lxTiinvcontMathasta, lxTiinvcontTempdesde, lxTiinvcontTemphasta, lxTiinvcontFamdesde, lxTiinvcontFamhasta, lxTiinvcontGrupodesde, lxTiinvcontGrupohasta, lxTiinvcontLineadesde, lxTiinvcontLineahasta, lxTiinvcontCategdesde, lxTiinvcontCateghasta, lxTiinvcontClasdesde, lxTiinvcontClashasta, lxTiinvcontTipodesde, lxTiinvcontTipohasta, lxTiinvcontMobs
				lxTiinvcontFmodifw =  .Fechamodificacionfw			lxTiinvcontFectrans =  .Fechatransferencia			lxTiinvcontFecimpo =  .Fechaimpo			lxTiinvcontFecexpo =  .Fechaexpo			lxTiinvcontCodigo =  .Codigo			lxTiinvcontHaltafw =  .Horaaltafw			lxTiinvcontHoraexpo =  .Horaexpo			lxTiinvcontHoraimpo =  .Horaimpo			lxTiinvcontBdaltafw =  .Basededatosaltafw			lxTiinvcontEsttrans =  .Estadotransferencia			lxTiinvcontBdmodifw =  .Basededatosmodificacionfw			lxTiinvcontSaltafw =  .Seriealtafw			lxTiinvcontHmodifw =  .Horamodificacionfw			lxTiinvcontVmodifw =  .Versionmodificacionfw			lxTiinvcontZadsfw =  .Zadsfw			lxTiinvcontValtafw =  .Versionaltafw			lxTiinvcontUmodifw =  .Usuariomodificacionfw			lxTiinvcontUaltafw =  .Usuarioaltafw			lxTiinvcontSmodifw =  .Seriemodificacionfw			lxTiinvcontDescrip =  .Descripcion			lxTiinvcontFaltafw =  .Fechaaltafw			lxTiinvcontFechad =  .Fechadesde			lxTiinvcontFechah =  .Fechahasta			lxTiinvcontArtdesde =  upper( .ArticuloDesde_PK ) 			lxTiinvcontArthasta =  upper( .ArticuloHasta_PK ) 			lxTiinvcontColdesde =  upper( .ColorDesde_PK ) 			lxTiinvcontColhasta =  upper( .ColorHasta_PK ) 			lxTiinvcontTaldesde =  upper( .TalleDesde_PK ) 			lxTiinvcontTalhasta =  upper( .TalleHasta_PK ) 			lxTiinvcontProvdesde =  upper( .ProveedorDesde_PK ) 			lxTiinvcontProvhasta =  upper( .ProveedorHasta_PK ) 			lxTiinvcontMatdesde =  upper( .MaterialDesde_PK ) 			lxTiinvcontMathasta =  upper( .MaterialHasta_PK ) 			lxTiinvcontTempdesde =  upper( .TemporadaDesde_PK ) 			lxTiinvcontTemphasta =  upper( .TemporadaHasta_PK ) 			lxTiinvcontFamdesde =  upper( .FamiliaDesde_PK ) 			lxTiinvcontFamhasta =  upper( .FamiliaHasta_PK ) 			lxTiinvcontGrupodesde =  upper( .GrupoDesde_PK ) 			lxTiinvcontGrupohasta =  upper( .GrupoHasta_PK ) 			lxTiinvcontLineadesde =  upper( .LineaDesde_PK ) 			lxTiinvcontLineahasta =  upper( .LineaHasta_PK ) 			lxTiinvcontCategdesde =  upper( .CategoriaDeArticuloDesde_PK ) 			lxTiinvcontCateghasta =  upper( .CategoriaDeArticuloHasta_PK ) 			lxTiinvcontClasdesde =  upper( .ClasificacionDesde_PK ) 			lxTiinvcontClashasta =  upper( .ClasificacionHasta_PK ) 			lxTiinvcontTipodesde =  upper( .TipoDeArticuloDesde_PK ) 			lxTiinvcontTipohasta =  upper( .TipoDeArticuloHasta_PK ) 			lxTiinvcontMobs =  .Obs
		endwith
		With this
			Local lxValorClavePrimaria as variant, lcValorClavePrimariaString as string
			lxValorClavePrimaria = this.oEntidad.CODIGO
			lcValorClavePrimariaString = transform( this.oEntidad.CODIGO )

			lcFiltro = ["Codigo" = ] + lcValorClavePrimariaString  + [ and  TIINVCONT.CODIGO != 0]
			text to lcSentencia noshow textmerge
				update ZooLogic.TIINVCONT set "Fmodifw" = <<"'" + this.ConvertirDateSql( lxTiinvcontFmodifw ) + "'">>, "Fectrans" = <<"'" + this.ConvertirDateSql( lxTiinvcontFectrans ) + "'">>, "Fecimpo" = <<"'" + this.ConvertirDateSql( lxTiinvcontFecimpo ) + "'">>, "Fecexpo" = <<"'" + this.ConvertirDateSql( lxTiinvcontFecexpo ) + "'">>, "Codigo" = <<lxTiinvcontCodigo>>, "Haltafw" = <<"'" + this.FormatearTextoSql( lxTiinvcontHaltafw ) + "'">>, "Horaexpo" = <<"'" + this.FormatearTextoSql( lxTiinvcontHoraexpo ) + "'">>, "Horaimpo" = <<"'" + this.FormatearTextoSql( lxTiinvcontHoraimpo ) + "'">>, "Bdaltafw" = <<"'" + this.FormatearTextoSql( lxTiinvcontBdaltafw ) + "'">>, "Esttrans" = <<"'" + this.FormatearTextoSql( lxTiinvcontEsttrans ) + "'">>, "Bdmodifw" = <<"'" + this.FormatearTextoSql( lxTiinvcontBdmodifw ) + "'">>, "Saltafw" = <<"'" + this.FormatearTextoSql( lxTiinvcontSaltafw ) + "'">>, "Hmodifw" = <<"'" + this.FormatearTextoSql( lxTiinvcontHmodifw ) + "'">>, "Vmodifw" = <<"'" + this.FormatearTextoSql( lxTiinvcontVmodifw ) + "'">>, "Zadsfw" = <<"'" + this.FormatearTextoSql( lxTiinvcontZadsfw ) + "'">>, "Valtafw" = <<"'" + this.FormatearTextoSql( lxTiinvcontValtafw ) + "'">>, "Umodifw" = <<"'" + this.FormatearTextoSql( lxTiinvcontUmodifw ) + "'">>, "Ualtafw" = <<"'" + this.FormatearTextoSql( lxTiinvcontUaltafw ) + "'">>, "Smodifw" = <<"'" + this.FormatearTextoSql( lxTiinvcontSmodifw ) + "'">>, "Descrip" = <<"'" + this.FormatearTextoSql( lxTiinvcontDescrip ) + "'">>, "Faltafw" = <<"'" + this.ConvertirDateSql( lxTiinvcontFaltafw ) + "'">>, "Fechad" = <<"'" + this.ConvertirDateSql( lxTiinvcontFechad ) + "'">>, "Fechah" = <<"'" + this.ConvertirDateSql( lxTiinvcontFechah ) + "'">>, "Artdesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontArtdesde ) + "'">>, "Arthasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontArthasta ) + "'">>, "Coldesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontColdesde ) + "'">>, "Colhasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontColhasta ) + "'">>, "Taldesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontTaldesde ) + "'">>, "Talhasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontTalhasta ) + "'">>, "Provdesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontProvdesde ) + "'">>, "Provhasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontProvhasta ) + "'">>, "Matdesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontMatdesde ) + "'">>, "Mathasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontMathasta ) + "'">>, "Tempdesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontTempdesde ) + "'">>, "Temphasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontTemphasta ) + "'">>, "Famdesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontFamdesde ) + "'">>, "Famhasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontFamhasta ) + "'">>, "Grupodesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontGrupodesde ) + "'">>, "Grupohasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontGrupohasta ) + "'">>, "Lineadesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontLineadesde ) + "'">>, "Lineahasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontLineahasta ) + "'">>, "Categdesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontCategdesde ) + "'">>, "Categhasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontCateghasta ) + "'">>, "Clasdesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontClasdesde ) + "'">>, "Clashasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontClashasta ) + "'">>, "Tipodesde" = <<"'" + this.FormatearTextoSql( lxTiinvcontTipodesde ) + "'">>, "Tipohasta" = <<"'" + this.FormatearTextoSql( lxTiinvcontTipohasta ) + "'">>, "Mobs" = <<"'" + this.FormatearTextoSql( lxTiinvcontMobs ) + "'">> where << lcFiltro >>
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
					this.oConexion.EjecutarSql( [UPDATE ZooLogic.TIINVCONT set  FMODIFW = ] + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'"+ [, FECTRANS = ] + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'"+ [, FECIMPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'"+ [, FECEXPO = ] + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'"+ [, CODIGO = ] + transform( &lcCursor..CODIGO )+ [, HORAEXPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"+ [, HORAIMPO = ] + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'"+ [, ESTTRANS = ] + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'"+ [, BDMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'"+ [, HMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'"+ [, VMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"+ [, ZADSFW = ] + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'"+ [, UMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'"+ [, SMODIFW = ] + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'"+ [, Descrip = ] + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'"+ [, FECHAD = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHAD ) + "'"+ [, FECHAH = ] + "'" + this.ConvertirDateSql( &lcCursor..FECHAH ) + "'"+ [, ArtDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ArtDesde ) + "'"+ [, ArtHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ArtHasta ) + "'"+ [, ColDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ColDesde ) + "'"+ [, ColHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ColHasta ) + "'"+ [, TalDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..TalDesde ) + "'"+ [, TalHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..TalHasta ) + "'"+ [, ProvDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ProvDesde ) + "'"+ [, ProvHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ProvHasta ) + "'"+ [, MatDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..MatDesde ) + "'"+ [, MatHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..MatHasta ) + "'"+ [, TempDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..TempDesde ) + "'"+ [, TempHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..TempHasta ) + "'"+ [, FamDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..FamDesde ) + "'"+ [, FamHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..FamHasta ) + "'"+ [, GrupoDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..GrupoDesde ) + "'"+ [, GrupoHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..GrupoHasta ) + "'"+ [, LineaDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..LineaDesde ) + "'"+ [, LineaHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..LineaHasta ) + "'"+ [, CategDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..CategDesde ) + "'"+ [, CategHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..CategHasta ) + "'"+ [, ClasDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..ClasDesde ) + "'"+ [, ClasHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..ClasHasta ) + "'"+ [, TipoDesde = ] + "'" + this.FormatearTextoSql( &lcCursor..TipoDesde ) + "'"+ [, TipoHasta = ] + "'" + this.FormatearTextoSql( &lcCursor..TipoHasta ) + "'"+ [, MObs = ] + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'" + [ Where CODIGO = ] + transform( &lcCursor..CODIGO ) )
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' recibido ( modifica existente' + lcMensajeExtra + ' ).', tlLoguear )
				else
					this.LoguearRecepcion( lcIdentificadorParaLoguear + ' no recibido ( existe una versión más actual en la base de datos ).', tlLoguear )
				endIf
			else
				Replace in &lcCursor ESTTRANS With [RECIBIDO], FECTRANS With ldFecha
				Text to lcCampos noShow
					 FMODIFW, FECTRANS, FECIMPO, FECEXPO, CODIGO, HALTAFW, HORAEXPO, HORAIMPO, BDALTAFW, ESTTRANS, BDMODIFW, SALTAFW, HMODIFW, VMODIFW, ZADSFW, VALTAFW, UMODIFW, UALTAFW, SMODIFW, Descrip, FAltaFW, FECHAD, FECHAH, ArtDesde, ArtHasta, ColDesde, ColHasta, TalDesde, TalHasta, ProvDesde, ProvHasta, MatDesde, MatHasta, TempDesde, TempHasta, FamDesde, FamHasta, GrupoDesde, GrupoHasta, LineaDesde, LineaHasta, CategDesde, CategHasta, ClasDesde, ClasHasta, TipoDesde, TipoHasta, MObs
				EndText
				local lcValoresCampos as string
lcValoresCampos = ''
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FMODIFW ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECTRANS ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECIMPO ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECEXPO ) + "'" + ',' + transform( &lcCursor..CODIGO ) + ',' + "'" + this.FormatearTextoSql( &lcCursor..HALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAEXPO ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..HORAIMPO ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ESTTRANS ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..BDMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..HMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VMODIFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..ZADSFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..VALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..UALTAFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..SMODIFW ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..Descrip ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FAltaFW ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHAD ) + "'" + ',' + "'" + this.ConvertirDateSql( &lcCursor..FECHAH ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ArtDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ArtHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ColDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ColHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TalDesde ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..TalHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ProvDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ProvHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MatDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..MatHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TempDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TempHasta ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..FamDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..FamHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..GrupoDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..GrupoHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LineaDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..LineaHasta ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..CategDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..CategHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClasDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..ClasHasta ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipoDesde ) + "'" + ',' + "'" + this.FormatearTextoSql( &lcCursor..TipoHasta ) + "'"
lcValoresCampos = lcValoresCampos  + ',' + "'" + this.FormatearTextoSql( &lcCursor..MObs ) + "'"
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
		* Validar ANTERIORES A 1/1/1753  FMODIFW   
		* Validar ANTERIORES A 1/1/1753  FECTRANS  
		* Validar ANTERIORES A 1/1/1753  FECIMPO   
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
"fmodifw" datetime  null, 
"fectrans" datetime  null, 
"fecimpo" datetime  null, 
"fecexpo" datetime  null, 
"codigo" numeric( 8, 0 )  null, 
"haltafw" char( 8 )  null, 
"horaexpo" char( 8 )  null, 
"horaimpo" char( 8 )  null, 
"bdaltafw" char( 8 )  null, 
"esttrans" char( 20 )  null, 
"bdmodifw" char( 8 )  null, 
"saltafw" char( 7 )  null, 
"hmodifw" char( 8 )  null, 
"vmodifw" char( 13 )  null, 
"zadsfw" varchar(max)  null, 
"valtafw" char( 13 )  null, 
"umodifw" char( 100 )  null, 
"ualtafw" char( 100 )  null, 
"smodifw" char( 7 )  null, 
"descrip" char( 40 )  null, 
"faltafw" datetime  null, 
"fechad" datetime  null, 
"fechah" datetime  null, 
"artdesde" char( 15 )  null, 
"arthasta" char( 15 )  null, 
"coldesde" char( 6 )  null, 
"colhasta" char( 6 )  null, 
"taldesde" char( 5 )  null, 
"talhasta" char( 5 )  null, 
"provdesde" char( 10 )  null, 
"provhasta" char( 10 )  null, 
"matdesde" char( 10 )  null, 
"mathasta" char( 10 )  null, 
"tempdesde" char( 5 )  null, 
"temphasta" char( 5 )  null, 
"famdesde" char( 10 )  null, 
"famhasta" char( 10 )  null, 
"grupodesde" char( 10 )  null, 
"grupohasta" char( 10 )  null, 
"lineadesde" char( 10 )  null, 
"lineahasta" char( 10 )  null, 
"categdesde" char( 10 )  null, 
"categhasta" char( 10 )  null, 
"clasdesde" char( 10 )  null, 
"clashasta" char( 10 )  null, 
"tipodesde" char( 10 )  null, 
"tipohasta" char( 10 )  null, 
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
			.AgregarMapeo('fmodifw','fmodifw')
			.AgregarMapeo('fectrans','fectrans')
			.AgregarMapeo('fecimpo','fecimpo')
			.AgregarMapeo('fecexpo','fecexpo')
			.AgregarMapeo('codigo','codigo')
			.AgregarMapeo('haltafw','haltafw')
			.AgregarMapeo('horaexpo','horaexpo')
			.AgregarMapeo('horaimpo','horaimpo')
			.AgregarMapeo('bdaltafw','bdaltafw')
			.AgregarMapeo('esttrans','esttrans')
			.AgregarMapeo('bdmodifw','bdmodifw')
			.AgregarMapeo('saltafw','saltafw')
			.AgregarMapeo('hmodifw','hmodifw')
			.AgregarMapeo('vmodifw','vmodifw')
			.AgregarMapeo('zadsfw','zadsfw')
			.AgregarMapeo('valtafw','valtafw')
			.AgregarMapeo('umodifw','umodifw')
			.AgregarMapeo('ualtafw','ualtafw')
			.AgregarMapeo('smodifw','smodifw')
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
			.AgregarMapeo('matdesde','matdesde')
			.AgregarMapeo('mathasta','mathasta')
			.AgregarMapeo('tempdesde','tempdesde')
			.AgregarMapeo('temphasta','temphasta')
			.AgregarMapeo('famdesde','famdesde')
			.AgregarMapeo('famhasta','famhasta')
			.AgregarMapeo('grupodesde','grupodesde')
			.AgregarMapeo('grupohasta','grupohasta')
			.AgregarMapeo('lineadesde','lineadesde')
			.AgregarMapeo('lineahasta','lineahasta')
			.AgregarMapeo('categdesde','categdesde')
			.AgregarMapeo('categhasta','categhasta')
			.AgregarMapeo('clasdesde','clasdesde')
			.AgregarMapeo('clashasta','clashasta')
			.AgregarMapeo('tipodesde','tipodesde')
			.AgregarMapeo('tipohasta','tipohasta')
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
				Update t Set t.FMODIFW = isnull( d.FMODIFW, t.FMODIFW ),t.FECTRANS = isnull( d.FECTRANS, t.FECTRANS ),t.FECIMPO = isnull( d.FECIMPO, t.FECIMPO ),t.FECEXPO = isnull( d.FECEXPO, t.FECEXPO ),t.CODIGO = isnull( d.CODIGO, t.CODIGO ),t.HALTAFW = isnull( d.HALTAFW, t.HALTAFW ),t.HORAEXPO = isnull( d.HORAEXPO, t.HORAEXPO ),t.HORAIMPO = isnull( d.HORAIMPO, t.HORAIMPO ),t.BDALTAFW = isnull( d.BDALTAFW, t.BDALTAFW ),t.ESTTRANS = isnull( d.ESTTRANS, t.ESTTRANS ),t.BDMODIFW = isnull( d.BDMODIFW, t.BDMODIFW ),t.SALTAFW = isnull( d.SALTAFW, t.SALTAFW ),t.HMODIFW = isnull( d.HMODIFW, t.HMODIFW ),t.VMODIFW = isnull( d.VMODIFW, t.VMODIFW ),t.ZADSFW = isnull( d.ZADSFW, t.ZADSFW ),t.VALTAFW = isnull( d.VALTAFW, t.VALTAFW ),t.UMODIFW = isnull( d.UMODIFW, t.UMODIFW ),t.UALTAFW = isnull( d.UALTAFW, t.UALTAFW ),t.SMODIFW = isnull( d.SMODIFW, t.SMODIFW ),t.DESCRIP = isnull( d.DESCRIP, t.DESCRIP ),t.FALTAFW = isnull( d.FALTAFW, t.FALTAFW ),t.FECHAD = isnull( d.FECHAD, t.FECHAD ),t.FECHAH = isnull( d.FECHAH, t.FECHAH ),t.ARTDESDE = isnull( d.ARTDESDE, t.ARTDESDE ),t.ARTHASTA = isnull( d.ARTHASTA, t.ARTHASTA ),t.COLDESDE = isnull( d.COLDESDE, t.COLDESDE ),t.COLHASTA = isnull( d.COLHASTA, t.COLHASTA ),t.TALDESDE = isnull( d.TALDESDE, t.TALDESDE ),t.TALHASTA = isnull( d.TALHASTA, t.TALHASTA ),t.PROVDESDE = isnull( d.PROVDESDE, t.PROVDESDE ),t.PROVHASTA = isnull( d.PROVHASTA, t.PROVHASTA ),t.MATDESDE = isnull( d.MATDESDE, t.MATDESDE ),t.MATHASTA = isnull( d.MATHASTA, t.MATHASTA ),t.TEMPDESDE = isnull( d.TEMPDESDE, t.TEMPDESDE ),t.TEMPHASTA = isnull( d.TEMPHASTA, t.TEMPHASTA ),t.FAMDESDE = isnull( d.FAMDESDE, t.FAMDESDE ),t.FAMHASTA = isnull( d.FAMHASTA, t.FAMHASTA ),t.GRUPODESDE = isnull( d.GRUPODESDE, t.GRUPODESDE ),t.GRUPOHASTA = isnull( d.GRUPOHASTA, t.GRUPOHASTA ),t.LINEADESDE = isnull( d.LINEADESDE, t.LINEADESDE ),t.LINEAHASTA = isnull( d.LINEAHASTA, t.LINEAHASTA ),t.CATEGDESDE = isnull( d.CATEGDESDE, t.CATEGDESDE ),t.CATEGHASTA = isnull( d.CATEGHASTA, t.CATEGHASTA ),t.CLASDESDE = isnull( d.CLASDESDE, t.CLASDESDE ),t.CLASHASTA = isnull( d.CLASHASTA, t.CLASHASTA ),t.TIPODESDE = isnull( d.TIPODESDE, t.TIPODESDE ),t.TIPOHASTA = isnull( d.TIPOHASTA, t.TIPOHASTA ),t.MOBS = isnull( d.MOBS, t.MOBS )
					from ZooLogic.TIINVCONT t inner join deleted d 
							 on t.CODIGO = d.CODIGO
				-- Fin Updates
				insert into ZooLogic.TIINVCONT(Fmodifw,Fectrans,Fecimpo,Fecexpo,Codigo,Haltafw,Horaexpo,Horaimpo,Bdaltafw,Esttrans,Bdmodifw,Saltafw,Hmodifw,Vmodifw,Zadsfw,Valtafw,Umodifw,Ualtafw,Smodifw,Descrip,Faltafw,Fechad,Fechah,Artdesde,Arthasta,Coldesde,Colhasta,Taldesde,Talhasta,Provdesde,Provhasta,Matdesde,Mathasta,Tempdesde,Temphasta,Famdesde,Famhasta,Grupodesde,Grupohasta,Lineadesde,Lineahasta,Categdesde,Categhasta,Clasdesde,Clashasta,Tipodesde,Tipohasta,Mobs)
					Select isnull( d.FMODIFW,''),isnull( d.FECTRANS,''),isnull( d.FECIMPO,''),isnull( d.FECEXPO,''),isnull( d.CODIGO,0),convert( char(8), getdate(), 108 ),isnull( d.HORAEXPO,''),isnull( d.HORAIMPO,''),isnull( d.BDALTAFW,''),isnull( d.ESTTRANS,''),isnull( d.BDMODIFW,''),isnull( d.SALTAFW,''),isnull( d.HMODIFW,''),isnull( d.VMODIFW,''),isnull( d.ZADSFW,''),isnull( d.VALTAFW,''),isnull( d.UMODIFW,''),isnull( d.UALTAFW,''),isnull( d.SMODIFW,''),isnull( d.DESCRIP,''),CONVERT(datetime, convert(varchar(10),getdate(),112) ),isnull( d.FECHAD,''),isnull( d.FECHAH,''),isnull( d.ARTDESDE,''),isnull( d.ARTHASTA,''),isnull( d.COLDESDE,''),isnull( d.COLHASTA,''),isnull( d.TALDESDE,''),isnull( d.TALHASTA,''),isnull( d.PROVDESDE,''),isnull( d.PROVHASTA,''),isnull( d.MATDESDE,''),isnull( d.MATHASTA,''),isnull( d.TEMPDESDE,''),isnull( d.TEMPHASTA,''),isnull( d.FAMDESDE,''),isnull( d.FAMHASTA,''),isnull( d.GRUPODESDE,''),isnull( d.GRUPOHASTA,''),isnull( d.LINEADESDE,''),isnull( d.LINEAHASTA,''),isnull( d.CATEGDESDE,''),isnull( d.CATEGHASTA,''),isnull( d.CLASDESDE,''),isnull( d.CLASHASTA,''),isnull( d.TIPODESDE,''),isnull( d.TIPOHASTA,''),isnull( d.MOBS,'')
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
					.Fechamodificacionfw = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIINVENTARIOACONT.Fechamodificacionfw, ctod( '  /  /    ' ) ) )
					.Fechatransferencia = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIINVENTARIOACONT.Fechatransferencia, ctod( '  /  /    ' ) ) )
					.Fechaimpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIINVENTARIOACONT.Fechaimpo, ctod( '  /  /    ' ) ) )
					.Fechaexpo = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIINVENTARIOACONT.Fechaexpo, ctod( '  /  /    ' ) ) )
					.Codigo = nvl( c_TIINVENTARIOACONT.Codigo, 0 )
					.Horaaltafw = nvl( c_TIINVENTARIOACONT.Horaaltafw, [] )
					.Horaexpo = nvl( c_TIINVENTARIOACONT.Horaexpo, [] )
					.Horaimpo = nvl( c_TIINVENTARIOACONT.Horaimpo, [] )
					.Basededatosaltafw = nvl( c_TIINVENTARIOACONT.Basededatosaltafw, [] )
					.Estadotransferencia = nvl( c_TIINVENTARIOACONT.Estadotransferencia, [] )
					.Basededatosmodificacionfw = nvl( c_TIINVENTARIOACONT.Basededatosmodificacionfw, [] )
					.Seriealtafw = nvl( c_TIINVENTARIOACONT.Seriealtafw, [] )
					.Horamodificacionfw = nvl( c_TIINVENTARIOACONT.Horamodificacionfw, [] )
					.Versionmodificacionfw = nvl( c_TIINVENTARIOACONT.Versionmodificacionfw, [] )
					lcValor = This.ObtenerMemo( 'c_Zadsfw')
					.Zadsfw = lcValor 
					.Versionaltafw = nvl( c_TIINVENTARIOACONT.Versionaltafw, [] )
					.Usuariomodificacionfw = nvl( c_TIINVENTARIOACONT.Usuariomodificacionfw, [] )
					.Usuarioaltafw = nvl( c_TIINVENTARIOACONT.Usuarioaltafw, [] )
					.Seriemodificacionfw = nvl( c_TIINVENTARIOACONT.Seriemodificacionfw, [] )
					.Descripcion = nvl( c_TIINVENTARIOACONT.Descripcion, [] )
					.Fechaaltafw = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIINVENTARIOACONT.Fechaaltafw, ctod( '  /  /    ' ) ) )
					.Fechadesde = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIINVENTARIOACONT.Fechadesde, ctod( '  /  /    ' ) ) )
					.Fechahasta = GoLibrerias.ObtenerFechaFormateada( nvl( c_TIINVENTARIOACONT.Fechahasta, ctod( '  /  /    ' ) ) )
					.Articulodesde_PK =  nvl( c_TIINVENTARIOACONT.Articulodesde, [] )
					.Articulohasta_PK =  nvl( c_TIINVENTARIOACONT.Articulohasta, [] )
					.Colordesde_PK =  nvl( c_TIINVENTARIOACONT.Colordesde, [] )
					.Colorhasta_PK =  nvl( c_TIINVENTARIOACONT.Colorhasta, [] )
					.Talledesde_PK =  nvl( c_TIINVENTARIOACONT.Talledesde, [] )
					.Tallehasta_PK =  nvl( c_TIINVENTARIOACONT.Tallehasta, [] )
					.Proveedordesde_PK =  nvl( c_TIINVENTARIOACONT.Proveedordesde, [] )
					.Proveedorhasta_PK =  nvl( c_TIINVENTARIOACONT.Proveedorhasta, [] )
					.Materialdesde_PK =  nvl( c_TIINVENTARIOACONT.Materialdesde, [] )
					.Materialhasta_PK =  nvl( c_TIINVENTARIOACONT.Materialhasta, [] )
					.Temporadadesde_PK =  nvl( c_TIINVENTARIOACONT.Temporadadesde, [] )
					.Temporadahasta_PK =  nvl( c_TIINVENTARIOACONT.Temporadahasta, [] )
					.Familiadesde_PK =  nvl( c_TIINVENTARIOACONT.Familiadesde, [] )
					.Familiahasta_PK =  nvl( c_TIINVENTARIOACONT.Familiahasta, [] )
					.Grupodesde_PK =  nvl( c_TIINVENTARIOACONT.Grupodesde, [] )
					.Grupohasta_PK =  nvl( c_TIINVENTARIOACONT.Grupohasta, [] )
					.Lineadesde_PK =  nvl( c_TIINVENTARIOACONT.Lineadesde, [] )
					.Lineahasta_PK =  nvl( c_TIINVENTARIOACONT.Lineahasta, [] )
					.Categoriadearticulodesde_PK =  nvl( c_TIINVENTARIOACONT.Categoriadearticulodesde, [] )
					.Categoriadearticulohasta_PK =  nvl( c_TIINVENTARIOACONT.Categoriadearticulohasta, [] )
					.Clasificaciondesde_PK =  nvl( c_TIINVENTARIOACONT.Clasificaciondesde, [] )
					.Clasificacionhasta_PK =  nvl( c_TIINVENTARIOACONT.Clasificacionhasta, [] )
					.Tipodearticulodesde_PK =  nvl( c_TIINVENTARIOACONT.Tipodearticulodesde, [] )
					.Tipodearticulohasta_PK =  nvl( c_TIINVENTARIOACONT.Tipodearticulohasta, [] )
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
			"Fmodifw" as "Fechamodificacionfw", "Fectrans" as "Fechatransferencia", "Fecimpo" as "Fechaimpo", "Fecexpo" as "Fechaexpo", "Codigo" as "Codigo", "Haltafw" as "Horaaltafw", "Horaexpo" as "Horaexpo", "Horaimpo" as "Horaimpo", "Bdaltafw" as "Basededatosaltafw", "Esttrans" as "Estadotransferencia", "Bdmodifw" as "Basededatosmodificacionfw", "Saltafw" as "Seriealtafw", "Hmodifw" as "Horamodificacionfw", "Vmodifw" as "Versionmodificacionfw", "Zadsfw" as "Zadsfw", "Valtafw" as "Versionaltafw", "Umodifw" as "Usuariomodificacionfw", "Ualtafw" as "Usuarioaltafw", "Smodifw" as "Seriemodificacionfw", "Descrip" as "Descripcion", "Faltafw" as "Fechaaltafw", "Fechad" as "Fechadesde", "Fechah" as "Fechahasta", "Artdesde" as "Articulodesde", "Arthasta" as "Articulohasta", "Coldesde" as "Colordesde", "Colhasta" as "Colorhasta", "Taldesde" as "Talledesde", "Talhasta" as "Tallehasta", "Provdesde" as "Proveedordesde", "Provhasta" as "Proveedorhasta", "Matdesde" as "Materialdesde", "Mathasta" as "Materialhasta", "Tempdesde" as "Temporadadesde", "Temphasta" as "Temporadahasta", "Famdesde" as "Familiadesde", "Famhasta" as "Familiahasta", "Grupodesde" as "Grupodesde", "Grupohasta" as "Grupohasta", "Lineadesde" as "Lineadesde", "Lineahasta" as "Lineahasta", "Categdesde" as "Categoriadearticulodesde", "Categhasta" as "Categoriadearticulohasta", "Clasdesde" as "Clasificaciondesde", "Clashasta" as "Clasificacionhasta", "Tipodesde" as "Tipodearticulodesde", "Tipohasta" as "Tipodearticulohasta", "Mobs" as "Obs"
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
	<row entidad="TIINVENTARIOACONT                       " atributo="FECHAMODIFICACIONFW                     " tabla="TIINVCONT      " campo="FMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha modificación                                                                                                                                              " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="FECHATRANSFERENCIA                      " tabla="TIINVCONT      " campo="FECTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha de novedad                                                                                                                                                " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="FECHAIMPO                               " tabla="TIINVCONT      " campo="FECIMPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha importación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="FECHAEXPO                               " tabla="TIINVCONT      " campo="FECEXPO   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Fecha exportación                                                                                                                                               " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="CODIGO                                  " tabla="TIINVCONT      " campo="CODIGO    " claveprimaria="true" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="N         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="2" etiqueta="Número                                                                                                                                                          " dominio="CODIGONUMERICO                " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="0" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="HORAALTAFW                              " tabla="TIINVCONT      " campo="HALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora alta                                                                                                                                                       " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="HORAEXPO                                " tabla="TIINVCONT      " campo="HORAEXPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora exportación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="HORAIMPO                                " tabla="TIINVCONT      " campo="HORAIMPO  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora importación                                                                                                                                                " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="BASEDEDATOSALTAFW                       " tabla="TIINVCONT      " campo="BDALTAFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos alta                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="ESTADOTRANSFERENCIA                     " tabla="TIINVCONT      " campo="ESTTRANS  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Estado de novedad                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="BASEDEDATOSMODIFICACIONFW               " tabla="TIINVCONT      " campo="BDMODIFW  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Base de datos modificación                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="SERIEALTAFW                             " tabla="TIINVCONT      " campo="SALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie alta                                                                                                                                                      " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="HORAMODIFICACIONFW                      " tabla="TIINVCONT      " campo="HMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Hora modificación                                                                                                                                               " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="VERSIONMODIFICACIONFW                   " tabla="TIINVCONT      " campo="VMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="ZADSFW                                  " tabla="TIINVCONT      " campo="ZADSFW    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="M         " longitud="0" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Acciones del sistema                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="VERSIONALTAFW                           " tabla="TIINVCONT      " campo="VALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="13" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Versión alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="USUARIOMODIFICACIONFW                   " tabla="TIINVCONT      " campo="UMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario modificación                                                                                                                                            " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="USUARIOALTAFW                           " tabla="TIINVCONT      " campo="UALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Usuario alta                                                                                                                                                    " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="SERIEMODIFICACIONFW                     " tabla="TIINVCONT      " campo="SMODIFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="7" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="0" etiqueta="Serie modificación                                                                                                                                              " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="0" alta="false" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="DESCRIPCION                             " tabla="TIINVCONT      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="4" etiqueta="Descripción                                                                                                                                                     " dominio="CARACTER                      " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="FECHAALTAFW                             " tabla="TIINVCONT      " campo="FALTAFW   " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=golibrerias.obtenerfecha()                                                                                                                                                                                                                                   " obligatorio="false" admitebusqueda="400" etiqueta="Fecha de alta                                                                                                                                                   " dominio="FECHA                         " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="1" orden="3" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="FECHADESDE                              " tabla="TIINVCONT      " campo="FECHAD    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="402" etiqueta="Fecha desde                                                                                                                                                     " dominio="EtiquetaFechaDesdeHasta       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="4" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="FECHAHASTA                              " tabla="TIINVCONT      " campo="FECHAH    " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="D         " longitud="8" decimales="0" valorsugerido="=golibrerias.obtenerfecha()                                                                                                                                                                                                                                   " obligatorio="false" admitebusqueda="6" etiqueta="Fecha hasta                                                                                                                                                     " dominio="EtiquetaFechaDesdeHasta       " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="3" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="ARTICULODESDE                           " tabla="TIINVCONT      " campo="ARTDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="404" etiqueta="Artículo desde                                                                                                                                                  " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="6" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="ARTICULOHASTA                           " tabla="TIINVCONT      " campo="ARTHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="ARTICULO                                " tipodato="C         " longitud="15" decimales="0" valorsugerido="ZZZZZZZZZZZZZZZ                                                                                                                                                                                                                                               " obligatorio="false" admitebusqueda="406" etiqueta="Artículo hasta                                                                                                                                                  " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="4" orden="7" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="COLORDESDE                              " tabla="TIINVCONT      " campo="COLDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="6" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="408" etiqueta="Color desde                                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="8" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="COLORHASTA                              " tabla="TIINVCONT      " campo="COLHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="COLOR                                   " tipodato="C         " longitud="6" decimales="0" valorsugerido="ZZZZZZ                                                                                                                                                                                                                                                        " obligatorio="false" admitebusqueda="410" etiqueta="Color hasta                                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="9" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="TALLEDESDE                              " tabla="TIINVCONT      " campo="TALDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLE                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="412" etiqueta="Talle desde                                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="10" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="TALLEHASTA                              " tabla="TIINVCONT      " campo="TALHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TALLE                                   " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZ                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="414" etiqueta="Talle hasta                                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="6" orden="11" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="PROVEEDORDESDE                          " tabla="TIINVCONT      " campo="PROVDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="416" etiqueta="Proveedor desde                                                                                                                                                 " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="7" orden="12" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="PROVEEDORHASTA                          " tabla="TIINVCONT      " campo="PROVHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="PROVEEDOR                               " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZ                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="418" etiqueta="Proveedor hasta                                                                                                                                                 " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="7" orden="13" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="MATERIALDESDE                           " tabla="TIINVCONT      " campo="MATDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MATERIAL                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="420" etiqueta="Material desde                                                                                                                                                  " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="11" orden="20" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="MATERIALHASTA                           " tabla="TIINVCONT      " campo="MATHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="MATERIAL                                " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="422" etiqueta="Material hasta                                                                                                                                                  " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="11" orden="21" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="TEMPORADADESDE                          " tabla="TIINVCONT      " campo="TEMPDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TEMPORADA                               " tipodato="C         " longitud="5" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="424" etiqueta="Temporada desde                                                                                                                                                 " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="13" orden="24" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="TEMPORADAHASTA                          " tabla="TIINVCONT      " campo="TEMPHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TEMPORADA                               " tipodato="C         " longitud="5" decimales="0" valorsugerido="ZZZZZ                                                                                                                                                                                                                                                         " obligatorio="false" admitebusqueda="426" etiqueta="Temporada hasta                                                                                                                                                 " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="13" orden="25" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="FAMILIADESDE                            " tabla="TIINVCONT      " campo="FAMDESDE  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="FAMILIA                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="428" etiqueta="Familia desde                                                                                                                                                   " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="15" orden="28" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="FAMILIAHASTA                            " tabla="TIINVCONT      " campo="FAMHASTA  " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="FAMILIA                                 " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="430" etiqueta="Familia hasta                                                                                                                                                   " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="15" orden="29" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="GRUPODESDE                              " tabla="TIINVCONT      " campo="GRUPODESDE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="GRUPO                                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="432" etiqueta="Grupo desde                                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="17" orden="32" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="GRUPOHASTA                              " tabla="TIINVCONT      " campo="GRUPOHASTA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="GRUPO                                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="434" etiqueta="Grupo hasta                                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="17" orden="33" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="LINEADESDE                              " tabla="TIINVCONT      " campo="LINEADESDE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LINEA                                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="436" etiqueta="Línea desde                                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="19" orden="36" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="LINEAHASTA                              " tabla="TIINVCONT      " campo="LINEAHASTA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="LINEA                                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="438" etiqueta="Línea hasta                                                                                                                                                     " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="19" orden="37" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="CATEGORIADEARTICULODESDE                " tabla="TIINVCONT      " campo="CATEGDESDE" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CATEGORIADEARTICULO                     " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="440" etiqueta="Categoría desde                                                                                                                                                 " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="21" orden="40" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="CATEGORIADEARTICULOHASTA                " tabla="TIINVCONT      " campo="CATEGHASTA" claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CATEGORIADEARTICULO                     " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="442" etiqueta="Categoría hasta                                                                                                                                                 " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="21" orden="41" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="CLASIFICACIONDESDE                      " tabla="TIINVCONT      " campo="CLASDESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONARTICULO                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="444" etiqueta="Clasificación desde                                                                                                                                             " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="23" orden="44" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="CLASIFICACIONHASTA                      " tabla="TIINVCONT      " campo="CLASHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="CLASIFICACIONARTICULO                   " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="446" etiqueta="Clasificación hasta                                                                                                                                             " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="23" orden="45" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="TIPODEARTICULODESDE                     " tabla="TIINVCONT      " campo="TIPODESDE " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPODEARTICULO                          " tipodato="C         " longitud="10" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="448" etiqueta="Tipo desde                                                                                                                                                      " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="29" orden="56" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="TIPODEARTICULOHASTA                     " tabla="TIINVCONT      " campo="TIPOHASTA " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="true" claveforanea="TIPODEARTICULO                          " tipodato="C         " longitud="10" decimales="0" valorsugerido="ZZZZZZZZZZ                                                                                                                                                                                                                                                    " obligatorio="false" admitebusqueda="450" etiqueta="Tipo hasta                                                                                                                                                      " dominio="EtiquetaCaracterDesdeHastaBusc" detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="29" orden="57" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIINVENTARIOACONT                       " atributo="OBS                                     " tabla="TIINVCONT      " campo="MOBS      " claveprimaria="false" muestrarelacion="false" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="20" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="452" etiqueta="Observaciones                                                                                                                                                   " dominio="OBSERVACION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones="                                                                                                                                                                                                                                                              " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="50" orden="80" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="405" etiqueta="Detalle Art.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ART On TIINVCONT.ARTDESDE = ART.ARTCOD And  ART.ARTCOD != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="ARTICULO                                " atributo="DESCRIPCION                             " tabla="ART            " campo="ARTDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="100" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="407" etiqueta="Detalle Art.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join ART On TIINVCONT.ARTHASTA = ART.ARTCOD And  ART.ARTCOD != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COLOR                                   " atributo="DESCRIPCION                             " tabla="COL            " campo="COLDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="409" etiqueta="Detalle Col.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COL On TIINVCONT.COLDESDE = COL.COLCOD And  COL.COLCOD != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="COLOR                                   " atributo="DESCRIPCION                             " tabla="COL            " campo="COLDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="411" etiqueta="Detalle Col.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join COL On TIINVCONT.COLHASTA = COL.COLCOD And  COL.COLCOD != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLE                                   " atributo="DESCRIPCION                             " tabla="TALLE          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="413" etiqueta="Detalle Tal.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TALLE On TIINVCONT.TALDESDE = TALLE.Codigo And  TALLE.CODIGO != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TALLE                                   " atributo="DESCRIPCION                             " tabla="TALLE          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="415" etiqueta="Detalle Tal.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TALLE On TIINVCONT.TALHASTA = TALLE.Codigo And  TALLE.CODIGO != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROV           " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="417" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROV On TIINVCONT.PROVDESDE = PROV.CLCOD And  PROV.CLCOD != ''                                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="PROVEEDOR                               " atributo="NOMBRE                                  " tabla="PROV           " campo="CLNOM     " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="60" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="419" etiqueta="Detalle Pro.                                                                                                                                                    " dominio="TEXTOBUSQUEDA                 " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join PROV On TIINVCONT.PROVHASTA = PROV.CLCOD And  PROV.CLCOD != ''                                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="5" orden="5" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MATERIAL                                " atributo="DESCRIPCION                             " tabla="MAT            " campo="MATDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="421" etiqueta="Detalle Mat.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MAT On TIINVCONT.MATDESDE = MAT.MATCOD And  MAT.MATCOD != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="MATERIAL                                " atributo="DESCRIPCION                             " tabla="MAT            " campo="MATDES    " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="40" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="423" etiqueta="Detalle Mat.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join MAT On TIINVCONT.MATHASTA = MAT.MATCOD And  MAT.MATCOD != ''                                                                                                                                                                                       " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TEMPORADA                               " atributo="DESCRIPCION                             " tabla="TEMPORADA      " campo="TDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="425" etiqueta="Detalle Tem.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TEMPORADA On TIINVCONT.TEMPDESDE = TEMPORADA.TCOD And  TEMPORADA.TCOD != ''                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TEMPORADA                               " atributo="DESCRIPCION                             " tabla="TEMPORADA      " campo="TDES      " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="427" etiqueta="Detalle Tem.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TEMPORADA On TIINVCONT.TEMPHASTA = TEMPORADA.TCOD And  TEMPORADA.TCOD != ''                                                                                                                                                                        " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FAMILIA                                 " atributo="DESCRIPCION                             " tabla="FAMILIA        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="429" etiqueta="Detalle Fam.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join FAMILIA On TIINVCONT.FAMDESDE = FAMILIA.Cod And  FAMILIA.COD != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="FAMILIA                                 " atributo="DESCRIPCION                             " tabla="FAMILIA        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="431" etiqueta="Detalle Fam.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join FAMILIA On TIINVCONT.FAMHASTA = FAMILIA.Cod And  FAMILIA.COD != ''                                                                                                                                                                                 " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPO                                   " atributo="DESCRIPCION                             " tabla="GRUPO          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="433" etiqueta="Detalle Gru.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join GRUPO On TIINVCONT.GRUPODESDE = GRUPO.Cod And  GRUPO.COD != ''                                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="GRUPO                                   " atributo="DESCRIPCION                             " tabla="GRUPO          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="435" etiqueta="Detalle Gru.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join GRUPO On TIINVCONT.GRUPOHASTA = GRUPO.Cod And  GRUPO.COD != ''                                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINEA                                   " atributo="DESCRIPCION                             " tabla="LINEA          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="437" etiqueta="Detalle Lín.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LINEA On TIINVCONT.LINEADESDE = LINEA.Cod And  LINEA.COD != ''                                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="LINEA                                   " atributo="DESCRIPCION                             " tabla="LINEA          " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="439" etiqueta="Detalle Lín.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join LINEA On TIINVCONT.LINEAHASTA = LINEA.Cod And  LINEA.COD != ''                                                                                                                                                                                     " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIADEARTICULO                     " atributo="DESCRIPCION                             " tabla="CATEGART       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="441" etiqueta="Detalle Cat.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CATEGART On TIINVCONT.CATEGDESDE = CATEGART.Cod And  CATEGART.COD != ''                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CATEGORIADEARTICULO                     " atributo="DESCRIPCION                             " tabla="CATEGART       " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="443" etiqueta="Detalle Cat.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CATEGART On TIINVCONT.CATEGHASTA = CATEGART.Cod And  CATEGART.COD != ''                                                                                                                                                                            " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASIFICACIONARTICULO                   " atributo="DESCRIPCION                             " tabla="CLASIFART      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="445" etiqueta="Detalle Cla.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLASIFART On TIINVCONT.CLASDESDE = CLASIFART.CODIGO And  CLASIFART.CODIGO != ''                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="CLASIFICACIONARTICULO                   " atributo="DESCRIPCION                             " tabla="CLASIFART      " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="447" etiqueta="Detalle Cla.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join CLASIFART On TIINVCONT.CLASHASTA = CLASIFART.CODIGO And  CLASIFART.CODIGO != ''                                                                                                                                                                    " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="1" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODEARTICULO                          " atributo="DESCRIPCION                             " tabla="TIPOART        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="449" etiqueta="Detalle Tip.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIPOART On TIINVCONT.TIPODESDE = TIPOART.Cod And  TIPOART.COD != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
	<row entidad="TIPODEARTICULO                          " atributo="DESCRIPCION                             " tabla="TIPOART        " campo="DESCRIP   " claveprimaria="false" muestrarelacion="true" permitemodificar="false" esentidad="false" claveforanea="                                        " tipodato="C         " longitud="50" decimales="0" valorsugerido="                                                                                                                                                                                                                                                              " obligatorio="false" admitebusqueda="451" etiqueta="Detalle Tip.                                                                                                                                                    " dominio="DESCRIPCION                   " detalle="false" tipo="E" atributoforaneo="                                                                                                                                                                                                                                                              " clavecandidata="0" mascara="                         " ofuncionalidad=" " relaciones=" Left Join TIPOART On TIINVCONT.TIPOHASTA = TIPOART.Cod And  TIPOART.COD != ''                                                                                                                                                                                " filtrobuscador="                                                                                                                                                                                                        " grupo="0" subgrupo="0" orden="2" alta="true" incluiratrib="false" excluiratrib="false" incluirbussubent="false" utilizamismarelacion="false"/>
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