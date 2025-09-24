
define class Din_EntidadIMPDIRCAJ as ent_ImputacionDirectaBase of ent_ImputacionDirectaBase.prg

	cNombre = 'IMPDIRCAJ'
	FECHAIMPO = ctod( '  /  /    ' )
	FECHATRANSFERENCIA = ctod( '  /  /    ' )
	FECHAMODIFICACIONFW = ctod( '  /  /    ' )
	FECHAEXPO = ctod( '  /  /    ' )
	FECHAALTAFW = ctod( '  /  /    ' )
	BASEDEDATOSALTAFW = []
	BASEDEDATOSMODIFICACIONFW = []
	HORAALTAFW = []
	ESTADOTRANSFERENCIA = []
	HORAEXPO = []
	VERSIONALTAFW = []
	ZADSFW = []
	VERSIONMODIFICACIONFW = []
	USUARIOMODIFICACIONFW = []
	USUARIOALTAFW = []
	HORAIMPO = []
	HORAMODIFICACIONFW = []
	SERIEALTAFW = []
	SERIEMODIFICACIONFW = []
	Observacion = []
	Imputacion_PK = 0
	Imputacion = null
	cAtributoPK = 'Numero'
	Numero = 0
	EstadoEnCartera = .F.
	EstadoEntregado = .F.
	Descripcion = []
	EstadoCobrado = .F.
	f_Concepto_Desde_PK = []
	f_Concepto_Desde = null
	EstadoDepositado = .F.
	f_Concepto_Hasta_PK = []
	f_Concepto_Hasta = null
	EstadoRechazado = .F.
	f_Clasificacion_Desde_PK = []
	f_Clasificacion_Desde = null
	EstadoBaja = .F.
	f_Clasificacion_Hasta_PK = []
	f_Clasificacion_Hasta = null
	EstadoDevuelto = .F.
	f_CuentaBancaria_Desde_PK = []
	f_CuentaBancaria_Desde = null
	EstadoComprometido = .F.
	f_CuentaBancaria_Hasta_PK = []
	f_CuentaBancaria_Hasta = null
	EstadoEnviado = .F.
	EstadoEnvioRechazado = .F.
	PlanDeCuentas_PK = []
	PlanDeCuentas = null
	Importancia = 0
	EstadoEnTransito = .F.
	EstadoEnCustodia = .F.
	f_Sucursal_Desde_PK = []
	f_Sucursal_Desde = null
	f_Sucursal_Hasta_PK = []
	f_Sucursal_Hasta = null
	f_TipoSucursal_Desde_PK = []
	f_TipoSucursal_Desde = null
	f_TipoSucursal_Hasta_PK = []
	f_TipoSucursal_Hasta = null
	BaseDeDatos = []
	lPermiteMinusculasPK = .f.
	cDescripcion =  [Imputación de concepto a cuenta contable]
	lEntidadEditable =  .t.
	lTieneVendedorComoClaveForanea = .f.
	cAtributoVendedor = ''
	oColeccionVS = null
	oColeccionVSFW = null
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Numero_Assign( txVal as variant ) as void
		local llConsulta as Boolean, llNuevo as boolean, llEdicion as boolean
		with this
			llEdicion = .EsEdicion()
			if .lLimpiando or .lCargando
				.Numero = .TransformarAlAsignar( txVal )
			else
				if llEdicion
				else
					llNuevo = .EsNuevo()
					.Numero = .TransformarAlAsignar( txVal )
					if empty( txVal ) and !llNuevo
						.Limpiar()
					else
						llConsulta = .oAD.ConsultarPorClavePrimaria()
						do case
							case !llNuevo and llConsulta
								.Cargar()
							case !llNuevo and !llConsulta
								.Limpiar()
								goServicios.Errores.LevantarExcepcionTexto( 'El dato buscado ' + alltrim( transform( txVal ) ) + ' de la entidad ' + upper( this.cDescripcion ) + ' no existe.', 9001 )
							case llNuevo and llConsulta
								.Numero = 0
								goServicios.Errores.LevantarExcepcion( 'El código ' + alltrim( transform( txVal ) ) + ' ya existe.' )
						endcase
					endif
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oAD_Access() as variant
		if !this.ldestroy and ( !vartype( this.oAD ) = 'O' or isnull( this.oAD ) )
			this.oAD = this.crearobjeto( 'Din_EntidadIMPDIRCAJAD_' + alltrim( _screen.zoo.app.TipoDeBase ))
			this.oAD.InyectarEntidad( this )
			this.oAD.Inicializar()
		endif
		return this.oAD
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function SetearEstadoNuevoEnItems() as Void
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function SetearEstadoEdicionEnItems() as Void
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidacionAtributos() as Boolean
	local lnLargoDecimal as integer, lnLargoEntero as Integer, lnLargoDecimal as integer, llRetorno as boolean 
		llRetorno = .T.

		 
		if ( vartype( this.FECHAIMPO) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAIMPO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FECHATRANSFERENCIA) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHATRANSFERENCIA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FECHAMODIFICACIONFW) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAMODIFICACIONFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FECHAEXPO) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAEXPO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.FECHAALTAFW) = 'D' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo FECHAALTAFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.BASEDEDATOSALTAFW) = 'C' )
			if len( alltrim( this.BASEDEDATOSALTAFW ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo BASEDEDATOSALTAFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo BASEDEDATOSALTAFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.BASEDEDATOSMODIFICACIONFW) = 'C' )
			if len( alltrim( this.BASEDEDATOSMODIFICACIONFW ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo BASEDEDATOSMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo BASEDEDATOSMODIFICACIONFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.HORAALTAFW) = 'C' )
			if len( alltrim( this.HORAALTAFW ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORAALTAFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORAALTAFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.ESTADOTRANSFERENCIA) = 'C' )
			if len( alltrim( this.ESTADOTRANSFERENCIA ) ) > 20
				This.AgregarInformacion( 'La longitud del valor del atributo ESTADOTRANSFERENCIA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ESTADOTRANSFERENCIA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.HORAEXPO) = 'C' )
			if len( alltrim( this.HORAEXPO ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORAEXPO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORAEXPO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.VERSIONALTAFW) = 'C' )
			if len( alltrim( this.VERSIONALTAFW ) ) > 13
				This.AgregarInformacion( 'La longitud del valor del atributo VERSIONALTAFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo VERSIONALTAFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.ZADSFW) = 'C' ) 
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ZADSFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.VERSIONMODIFICACIONFW) = 'C' )
			if len( alltrim( this.VERSIONMODIFICACIONFW ) ) > 13
				This.AgregarInformacion( 'La longitud del valor del atributo VERSIONMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo VERSIONMODIFICACIONFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.USUARIOMODIFICACIONFW) = 'C' )
			if len( alltrim( this.USUARIOMODIFICACIONFW ) ) > 100
				This.AgregarInformacion( 'La longitud del valor del atributo USUARIOMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo USUARIOMODIFICACIONFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.USUARIOALTAFW) = 'C' )
			if len( alltrim( this.USUARIOALTAFW ) ) > 100
				This.AgregarInformacion( 'La longitud del valor del atributo USUARIOALTAFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo USUARIOALTAFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.HORAIMPO) = 'C' )
			if len( alltrim( this.HORAIMPO ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORAIMPO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORAIMPO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.HORAMODIFICACIONFW) = 'C' )
			if len( alltrim( this.HORAMODIFICACIONFW ) ) > 8
				This.AgregarInformacion( 'La longitud del valor del atributo HORAMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo HORAMODIFICACIONFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.SERIEALTAFW) = 'C' )
			if len( alltrim( this.SERIEALTAFW ) ) > 7
				This.AgregarInformacion( 'La longitud del valor del atributo SERIEALTAFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SERIEALTAFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.SERIEMODIFICACIONFW) = 'C' )
			if len( alltrim( this.SERIEMODIFICACIONFW ) ) > 7
				This.AgregarInformacion( 'La longitud del valor del atributo SERIEMODIFICACIONFW es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo SERIEMODIFICACIONFW no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Observacion) = 'C' ) 
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo OBSERVACION no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Numero) = 'N' )
			lnLargoEntero  = len( transform( int( this.NUMERO ) ) ) 
			lnValorDelDecimal = this.NUMERO - int( this.NUMERO)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 8
				This.AgregarInformacion( 'La longitud entera del valor del atributo NUMERO es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo NUMERO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.EstadoEnCartera) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ESTADOENCARTERA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.EstadoEntregado) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ESTADOENTREGADO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Descripcion) = 'C' )
			if len( alltrim( this.DESCRIPCION ) ) > 50
				This.AgregarInformacion( 'La longitud del valor del atributo DESCRIPCION es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo DESCRIPCION no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.EstadoCobrado) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ESTADOCOBRADO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.EstadoDepositado) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ESTADODEPOSITADO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.EstadoRechazado) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ESTADORECHAZADO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.EstadoBaja) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ESTADOBAJA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.EstadoDevuelto) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ESTADODEVUELTO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.EstadoComprometido) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ESTADOCOMPROMETIDO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.EstadoEnviado) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ESTADOENVIADO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.EstadoEnvioRechazado) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ESTADOENVIORECHAZADO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.Importancia) = 'N' )
			lnLargoEntero  = len( transform( int( this.IMPORTANCIA ) ) ) 
			lnValorDelDecimal = this.IMPORTANCIA - int( this.IMPORTANCIA)
			lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
			if lnLargoEntero > 5
				This.AgregarInformacion( 'La longitud entera del valor del atributo IMPORTANCIA es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo IMPORTANCIA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.EstadoEnTransito) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ESTADOENTRANSITO no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.EstadoEnCustodia) = 'L' )
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo ESTADOENCUSTODIA no es el correcto.')
			llRetorno = .F.
		Endif
		 
		if ( vartype( this.BaseDeDatos) = 'C' )
			if len( alltrim( this.BASEDEDATOS ) ) > 21
				This.AgregarInformacion( 'La longitud del valor del atributo BASEDEDATOS es mayor a la permitida.' )
				llRetorno = .F.
			Endif
		else
			This.AgregarInformacion( 'El tipo de dato para el atributo BASEDEDATOS no es el correcto.')
			llRetorno = .F.
		Endif

		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidacionBasica() as boolean
		Local llRetorno as boolean, llVotacion as boolean
		llRetorno = .T.
		llVotacion = .T.

		llRetorno = dodefault()

		With This
			llRetorno = .ValidarImputacion() and llRetorno
			llRetorno = .ValidarPlandecuentas() and llRetorno
			llRetorno = .ValidarImportancia() and llRetorno
			llRetorno = .ValidacionAtributos() and llRetorno
			llRetorno = .ValidacionDetalles() and llRetorno
			if .VerificarContexto( 'CB' )
			else
				llRetorno = .ValidacionTimestamp() and llRetorno
			endif
		EndWith

		If Empty( this.NUMERO )
			llRetorno = .F.
			This.AgregarInformacion( 'No se puede grabar. Código Vacío', 0 )
		Endif
		if This.ValidarIngreso( transform( this.NUMERO ) )
		else
			llRetorno = .F.
			this.AgregarInformacion( 'Caracteres Inválidos en el código', 0 )
		EndIf
			return llRetorno and llVotacion

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidacionTimestamp() as Boolean

	*--------------------------------------------------------------------------------------------------------
	function ValidacionDetalles() as Boolean
		local llRetorno as boolean, llValAux as boolean
		llRetorno = dodefault()
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ActualizarEstado() as void

	endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearComponentes() as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarImportancia() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Importancia )
			this.AgregarInformacion( 'Debe cargar el campo Importancia', 9005, 'Importancia' )
			llRetorno = .F.
		endif
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarImputacion() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.Imputacion_PK )
		else
			If this.Imputacion.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.Imputacion_PK ))+ ' de la entidad ' +  upper( this.Imputacion.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Concepto_Desde() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Concepto_Desde_PK )
		else
			If this.f_Concepto_Desde.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Concepto_Desde_PK ))+ ' de la entidad ' +  upper( this.f_Concepto_Desde.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Concepto_Hasta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Concepto_Hasta_PK )
		else
			If this.f_Concepto_Hasta.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Concepto_Hasta_PK ))+ ' de la entidad ' +  upper( this.f_Concepto_Hasta.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Clasificacion_Desde() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Clasificacion_Desde_PK )
		else
			If this.f_Clasificacion_Desde.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Clasificacion_Desde_PK ))+ ' de la entidad ' +  upper( this.f_Clasificacion_Desde.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Clasificacion_Hasta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Clasificacion_Hasta_PK )
		else
			If this.f_Clasificacion_Hasta.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Clasificacion_Hasta_PK ))+ ' de la entidad ' +  upper( this.f_Clasificacion_Hasta.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_CuentaBancaria_Desde() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_CuentaBancaria_Desde_PK )
		else
			If this.f_CuentaBancaria_Desde.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_CuentaBancaria_Desde_PK ))+ ' de la entidad ' +  upper( this.f_CuentaBancaria_Desde.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_CuentaBancaria_Hasta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_CuentaBancaria_Hasta_PK )
		else
			If this.f_CuentaBancaria_Hasta.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_CuentaBancaria_Hasta_PK ))+ ' de la entidad ' +  upper( this.f_CuentaBancaria_Hasta.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarPlanDeCuentas() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.PlanDeCuentas_PK )
			this.AgregarInformacion( 'Debe cargar el campo Cuenta', 9005, 'PlanDeCuentas' )
			llRetorno = .F.
		else
			If this.PlanDeCuentas.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.PlanDeCuentas_PK ))+ ' de la entidad ' +  upper( this.PlanDeCuentas.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Sucursal_Desde() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Sucursal_Desde_PK )
		else
			If this.f_Sucursal_Desde.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Sucursal_Desde_PK ))+ ' de la entidad ' +  upper( this.f_Sucursal_Desde.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_Sucursal_Hasta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_Sucursal_Hasta_PK )
		else
			If this.f_Sucursal_Hasta.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_Sucursal_Hasta_PK ))+ ' de la entidad ' +  upper( this.f_Sucursal_Hasta.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_TipoSucursal_Desde() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_TipoSucursal_Desde_PK )
		else
			If this.f_TipoSucursal_Desde.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_TipoSucursal_Desde_PK ))+ ' de la entidad ' +  upper( this.f_TipoSucursal_Desde.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validarf_TipoSucursal_Hasta() as boolean
		local llRetorno as boolean
		llRetorno = dodefault()
		if empty( this.f_TipoSucursal_Hasta_PK )
		else
			If this.f_TipoSucursal_Hasta.oAD.ConsultarPorClavePrimaria()
			Else
				this.AgregarInformacion( 'El dato buscado ' + alltrim(transform( this.f_TipoSucursal_Hasta_PK ))+ ' de la entidad ' +  upper( this.f_TipoSucursal_Hasta.cDescripcion ) + ' no existe.')
				llRetorno = .F.
			endif
		endif
		Return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Grabar() As Void
	Local llRetorno As Boolean, llValidar as boolean, ;
	loEx As Exception, loError As Exception, llNuevo as Boolean, llEdicion as Boolean, llErrorAlValidar as Boolean 

	llValidar = .F.
	This.LimpiarRegistrosDeActividadAlGrabar()
	

	With This
		llNuevo = .EsNuevo()
		llEdicion = .EsEdicion()
		if llNuevo or llEdicion
			try
				.lProcesando = .T.
				this.ActualizarProgressBar( 20 )
				.LimpiarInformacion()
				this.ActualizarProgressBar( 30 )
				local lcAgrupadorDeActividad as String
				lcAgrupadorDeActividad = '<GDA:' + sys( 2015 ) + '>'
				This.IniciarRegistroDeActividadExtendido( 'Grabar' )
				This.IniciarRegistroDeActividadExtendido( 'AntesDeGrabar' )
				If .AntesDeGrabar()
					This.EstablecerTiemposEnRegistroDeActividadExtendido( 'AntesDeGrabar' )
					this.ActualizarProgressBar( 40 )
				try
					This.IniciarRegistroDeActividadExtendido( 'Validar' )
					llValidar = .Validar()
					This.EstablecerTiemposEnRegistroDeActividadExtendido( 'Validar' )
				Catch To loError
					llErrorAlValidar = .t.
					.ErrorAlValidar()
					This.EliminarRegistrosDeActividad()
					goServicios.Errores.LevantarExcepcion( loError )
				finally
					if !llErrorAlValidar and !llValidar
						.ErrorAlValidar()
					endif
				endtry
					this.ActualizarProgressBar( 60 )
					If llValidar
						try
							this.ActualizarProgressBar( 70 )
							.SetearComponentes()
							this.ActualizarProgressBar( 80 )
							if llNuevo
								This.IniciarRegistroDeActividadExtendido( 'oAD_Insertar' )
								lxCodigo = .oAD.Insertar()
								This.EstablecerTiemposEnRegistroDeActividadExtendido( 'oAD_Insertar' )
								
							else
								This.IniciarRegistroDeActividadExtendido( 'oAD_Actualizar' )
								.oAD.Actualizar()
								This.EstablecerTiemposEnRegistroDeActividadExtendido( 'oAD_Actualizar' )
							endif
							this.ActualizarProgressBar( 90 )
						Catch To loError
							This.EliminarRegistrosDeActividad()
							goServicios.Errores.LevantarExcepcion( loError )
						Finally
						EndTry
						This.IniciarRegistroDeActividadExtendido( 'DespuesDeGrabar' )
						Try
							llValidar = .DespuesDeGrabar()
						Catch to loError
							llValidar = .T.
							loEx = Newobject( 'ZooException', 'ZooException.prg' )
							loEx.Grabar( loError )
							This.oMensaje.Advertir( 'Se ha producido una excepción no controlada durante el proceso posterior a la grabación.Verifique el log de errores para mas detalles.')
						EndTry
						This.EstablecerTiemposEnRegistroDeActividadExtendido( 'DespuesDeGrabar' )
						Store .F. To .lEdicion , .lNuevo
						.actualizarEstado()
					endif
				endif
			Catch To loError
				This.EliminarRegistrosDeActividad()
				loEx = Newobject( 'ZooException', 'ZooException.prg' )
				With loEx
					.Grabar( loError )
					.Throw()
				EndWith
			finally
				.lProcesando = .F.
			EndTry
		else
			This.EliminarRegistrosDeActividad()
			local loEx as Object
			loEx = Newobject( 'ZooException', 'ZooException.prg' )
			With loEx
				.Message = 'Error al intentar Grabar'
				.Details = 'No se puede grabar sin estar en estado NUEVO o EDICION'
				.Grabar()
				.Throw()
			endwith
		endif
		
		If llValidar
			This.EstablecerTiemposEnRegistroDeActividadExtendido( 'Grabar' )
			lcAgrupadorDeActividad = lcAgrupadorDeActividad + '<PK:' + transform( This.NUMERO ) + '>'
			This.FinalizarRegistrosDeActividad( lcAgrupadorDeActividad )
		else
			This.EliminarRegistrosDeActividad()
			loEx = Newobject( 'ZooException', 'ZooException.prg' )
			loEx.oInformacion = .ObtenerInformacion()
			loEx.Throw()
		Endif
	Endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function _Nuevo() As Boolean

		if this.EsNuevo()
			goServicios.Errores.LevantarExcepcion( "Cancele o grabe antes de intentar hacer 'Nuevo'." )
		else
			With This
				.lEdicion = .F.
				.lAnular = .F.
				.lNuevo = .T.
				.limpiar()
				.actualizarEstado()
				.SetearColeccionSentenciasAnterior_NUEVO()
			endwith
		endif

		dodefault()
		This.InicializarComponentes( .T. )

	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function _Modificar() As void
		Local llValidacion as boolean, llVotacion as boolean, loEx as exception

		With This
			llValidacion = .ValidarPK()
			If llValidacion
				.Buscar()
				.Cargar()
				.SetearColeccionSentenciasAnterior_MODIFICAR()
				.lEdicion = .T.
				.lNuevo = .F.
				.lAnular = .F.
				.actualizarEstado()
			else
				loEx = _screen.zoo.crearObjeto( 'zooException' )
				loEx.oInformacion = this.oInformacion
				loEx.Throw()
			Endif
		Endwith

	dodefault()

	Endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected function _EliminarSinValidaciones() as Void
		Local llValidacion as boolean, llVotacion as boolean, loEx as exception
		llVotacion = .T.
		With This
			if .lEliminar
				llValidacion = .ValidarPK()
				If llValidacion
				.SetearColeccionSentenciasAnterior_Eliminar()
					Store .F. To .lEdicion, .lNuevo
					.oAD.Eliminar()
					.actualizarEstado()
				else
					loEx = _screen.zoo.crearObjeto( 'zooException' )
					loEx.oInformacion = this.oInformacion
					loEx.throw()
				endif
			endif
		Endwith

	dodefault()

	Endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function _Cancelar() As void
		local loEx As zooException of zooException.prg 

		With This

			Do Case
				case .lNuevo
					Store .F. To .lEdicion, .lNuevo
					.limpiar()

				case !.lNuevo and !.lEdicion
					loEx = Newobject( 'ZooException', 'ZooException.prg' )
					With loEx
						.Message = 'Error al intentar hacer cancelar'
						.Details = "Para hacer 'Cancelar' debe estar en modo Nuevo o Edicion"
						.Grabar()
						.Throw()
					endwith

				otherwise
					.Buscar()
					.Cargar()
					Store .F. To .lEdicion, .lNuevo

			EndCase
			.actualizarEstado()
		EndWith

		dodefault()

	Endfunc
					*-----------------------------------------------------------------------------------------
	protected Function ValidarExistencia() As Boolean
		local llRetorno as Boolean
		if This.EsNuevo()
			llRetorno = .F.
		else
			llRetorno = dodefault()
		endif
		return llRetorno
	endfunc	
			*-----------------------------------------------------------------------------------------
	function oNumeraciones_Access() as variant
		if !this.ldestroy and ( !vartype( this.oNumeraciones ) = 'O' or isnull( this.oNumeraciones ) )
			this.oNumeraciones = this.CrearObjeto( 'Numeraciones' )
			this.oNumeraciones.Inicializar()
			this.oNumeraciones.SetearEntidad( this )
		endif
		return this.oNumeraciones
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function obtenerAtributosObligatorios() as ZooColeccion
		local loAtributosObligatorios as ZooColeccion
		loAtributosObligatorios = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		loAtributosObligatorios.add( 'NUMERO' )
		loAtributosObligatorios.add( 'PLANDECUENTAS' )
		loAtributosObligatorios.add( 'IMPORTANCIA' )
		return loAtributosObligatorios

	endfunc
	*--------------------------------------------------------------------------------------------------------
	Protected Function _Buscar() As void
		local llRetorno as Boolean, loEx as Exception, lcAtributo as String, lcMensaje as String

		lcAtributo = This.ObtenerAtributoClavePrimaria()
		if empty( This.&lcAtributo )
			llRetorno = this.oAD.ConsultarPorClaveCandidata()
			lcMensaje = 'El dato buscado  de la entidad ' + upper( this.cDescripcion ) + ' no existe.'
		else
			llRetorno = this.oAD.ConsultarPorClavePrimaria()
			lcMensaje = 'El dato buscado ' + alltrim( transform( This.NUMERO ) ) + ' de la entidad ' + upper( this.cDescripcion ) + ' no existe.'
		endif
		if llRetorno
		else
			goServicios.Errores.LevantarExcepcion( lcMensaje )
		endif
	endfunc	
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_NUEVO() as Void
	
		dodefault()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_MODIFICAR() as Void
	
		dodefault()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_ANULAR() as Void
	
		dodefault()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function SetearColeccionSentenciasAnterior_ELIMINAR() as Void
	
		dodefault()
	
	Endfunc
	*--------------------------------------------------------------------------------------------------------
	function ObtenerFuncionalidades() as String
		return '<HABILITARIMPOINSEGURA><IMPOGENERICA><EXPOGENERICA>'
	Endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as Void
		dodefault()
		this.lPermiteMinusculasPK = goParametros.Nucleo.PermiteCodigosEnMinusculas
		this.Enlazar( 'lNuevo', 'SetearEstadoNuevoEnItems' )
		this.Enlazar( 'lEdicion', 'SetearEstadoEdicionEnItems' )
		this.lHabilitaEnviarAlGrabar = .T.
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_concepto_hasta()','F_concepto_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_clasificacion_hasta()','F_clasificacion_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_cuentabancaria_hasta()','F_cuentabancaria_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_sucursal_hasta()','F_sucursal_hasta')
		this.oColeccionVSFW.agregar('.ValorSugeridoFWF_tiposucursal_hasta()','F_tiposucursal_hasta')
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'IMPDIRCAJ', '')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Imputacion_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Imputacion_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		this.Imputacion_PK = lxVal

		if this.Validar_Imputacion( lxVal, lxValOld )
			This.Setear_Imputacion( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_concepto_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_concepto_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_concepto_desde_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_concepto_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_concepto_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_concepto_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_clasificacion_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_clasificacion_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_clasificacion_desde.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_clasificacion_desde )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_clasificacion_desde_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_clasificacion_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_clasificacion_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		if txVal = lxValOld or empty( txVal )
			lxVal = txVal
		else
			this.lBuscandoCodigo = .t.
			if !this.lEsSubEntidad and ( this.EsNuevo() or this.EsEdicion() )
				lxVal = This.F_clasificacion_hasta.oComportamientoCodigoSugerido.ObtenerPKaAsignar( txVal, This.F_clasificacion_hasta )
			else
				lxVal = txVal
			endif
			this.lBuscandoCodigo = .f.
		endif
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_clasificacion_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_cuentabancaria_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_cuentabancaria_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.F_cuentabancaria_desde_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_cuentabancaria_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_cuentabancaria_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.F_cuentabancaria_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Plandecuentas_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Plandecuentas_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 30, padr( lxVal, 30 ), lxVal )
		this.Plandecuentas_PK = lxVal

		if this.Validar_Plandecuentas( lxVal, lxValOld )
			This.Setear_Plandecuentas( lxVal )
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_sucursal_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_sucursal_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_sucursal_desde_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_sucursal_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_sucursal_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_sucursal_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_tiposucursal_desde_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_tiposucursal_desde_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_tiposucursal_desde_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_tiposucursal_hasta_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.F_tiposucursal_hasta_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.F_tiposucursal_hasta_PK = lxVal

		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Imputacion( txVal as variant ) as void

		this.Imputacion.NUMERO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_concepto_desde( txVal as variant ) as void

		this.F_concepto_desde.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_concepto_hasta( txVal as variant ) as void

		this.F_concepto_hasta.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_clasificacion_desde( txVal as variant ) as void

		this.F_clasificacion_desde.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_clasificacion_hasta( txVal as variant ) as void

		this.F_clasificacion_hasta.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_cuentabancaria_desde( txVal as variant ) as void

		this.F_cuentabancaria_desde.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_cuentabancaria_hasta( txVal as variant ) as void

		this.F_cuentabancaria_hasta.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Plandecuentas( txVal as variant ) as void

		this.Plandecuentas.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_sucursal_desde( txVal as variant ) as void

		this.F_sucursal_desde.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_sucursal_hasta( txVal as variant ) as void

		this.F_sucursal_hasta.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_tiposucursal_desde( txVal as variant ) as void

		this.F_tiposucursal_desde.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_F_tiposucursal_hasta( txVal as variant ) as void

		this.F_tiposucursal_hasta.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Imputacion( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_concepto_desde( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_concepto_hasta( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_clasificacion_desde( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_clasificacion_hasta( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_cuentabancaria_desde( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_cuentabancaria_hasta( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Plandecuentas( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_sucursal_desde( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_sucursal_hasta( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_tiposucursal_desde( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_F_tiposucursal_hasta( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechaimpo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechaimpo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechaimpo( lxVal )
				this.ValidarDominio_Fecha( lxVal )
				this.Setear_Fechaimpo( lxVal )
			EndIf
		Else
			This.Setear_Fechaimpo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechatransferencia_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechatransferencia
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechatransferencia( lxVal )
				this.ValidarDominio_Fecha( lxVal )
				this.Setear_Fechatransferencia( lxVal )
			EndIf
		Else
			This.Setear_Fechatransferencia( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechamodificacionfw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechamodificacionfw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechamodificacionfw( lxVal )
				this.ValidarDominio_Fecha( lxVal )
				this.Setear_Fechamodificacionfw( lxVal )
			EndIf
		Else
			This.Setear_Fechamodificacionfw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechaexpo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechaexpo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechaexpo( lxVal )
				this.ValidarDominio_Fecha( lxVal )
				this.Setear_Fechaexpo( lxVal )
			EndIf
		Else
			This.Setear_Fechaexpo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fechaaltafw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fechaaltafw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fechaaltafw( lxVal )
				this.ValidarDominio_Fecha( lxVal )
				this.Setear_Fechaaltafw( lxVal )
			EndIf
		Else
			This.Setear_Fechaaltafw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Basededatosaltafw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Basededatosaltafw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Basededatosaltafw( lxVal )
				this.Setear_Basededatosaltafw( lxVal )
			EndIf
		Else
			This.Setear_Basededatosaltafw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Basededatosmodificacionfw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Basededatosmodificacionfw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Basededatosmodificacionfw( lxVal )
				this.Setear_Basededatosmodificacionfw( lxVal )
			EndIf
		Else
			This.Setear_Basededatosmodificacionfw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Horaaltafw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Horaaltafw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Horaaltafw( lxVal )
				this.Setear_Horaaltafw( lxVal )
			EndIf
		Else
			This.Setear_Horaaltafw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Estadotransferencia_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Estadotransferencia
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Estadotransferencia( lxVal )
				this.Setear_Estadotransferencia( lxVal )
			EndIf
		Else
			This.Setear_Estadotransferencia( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Horaexpo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Horaexpo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Horaexpo( lxVal )
				this.Setear_Horaexpo( lxVal )
			EndIf
		Else
			This.Setear_Horaexpo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Versionaltafw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Versionaltafw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Versionaltafw( lxVal )
				this.Setear_Versionaltafw( lxVal )
			EndIf
		Else
			This.Setear_Versionaltafw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Zadsfw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Zadsfw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Zadsfw( lxVal )
				this.Setear_Zadsfw( lxVal )
			EndIf
		Else
			This.Setear_Zadsfw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Versionmodificacionfw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Versionmodificacionfw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Versionmodificacionfw( lxVal )
				this.Setear_Versionmodificacionfw( lxVal )
			EndIf
		Else
			This.Setear_Versionmodificacionfw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Usuariomodificacionfw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Usuariomodificacionfw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Usuariomodificacionfw( lxVal )
				this.Setear_Usuariomodificacionfw( lxVal )
			EndIf
		Else
			This.Setear_Usuariomodificacionfw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Usuarioaltafw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Usuarioaltafw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Usuarioaltafw( lxVal )
				this.Setear_Usuarioaltafw( lxVal )
			EndIf
		Else
			This.Setear_Usuarioaltafw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Horaimpo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Horaimpo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Horaimpo( lxVal )
				this.Setear_Horaimpo( lxVal )
			EndIf
		Else
			This.Setear_Horaimpo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Horamodificacionfw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Horamodificacionfw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Horamodificacionfw( lxVal )
				this.Setear_Horamodificacionfw( lxVal )
			EndIf
		Else
			This.Setear_Horamodificacionfw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Seriealtafw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Seriealtafw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Seriealtafw( lxVal )
				this.Setear_Seriealtafw( lxVal )
			EndIf
		Else
			This.Setear_Seriealtafw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Seriemodificacionfw_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Seriemodificacionfw
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Seriemodificacionfw( lxVal )
				this.Setear_Seriemodificacionfw( lxVal )
			EndIf
		Else
			This.Setear_Seriemodificacionfw( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Observacion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Observacion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Observacion( lxVal )
				this.Setear_Observacion( lxVal )
			EndIf
		Else
			This.Setear_Observacion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Estadoencartera_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Estadoencartera
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Estadoencartera( lxVal )
				this.Setear_Estadoencartera( lxVal )
			EndIf
		Else
			This.Setear_Estadoencartera( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Estadoentregado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Estadoentregado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Estadoentregado( lxVal )
				this.Setear_Estadoentregado( lxVal )
			EndIf
		Else
			This.Setear_Estadoentregado( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Descripcion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Descripcion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Descripcion( lxVal )
				this.Setear_Descripcion( lxVal )
			EndIf
		Else
			This.Setear_Descripcion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Estadocobrado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Estadocobrado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Estadocobrado( lxVal )
				this.Setear_Estadocobrado( lxVal )
			EndIf
		Else
			This.Setear_Estadocobrado( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Estadodepositado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Estadodepositado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Estadodepositado( lxVal )
				this.Setear_Estadodepositado( lxVal )
			EndIf
		Else
			This.Setear_Estadodepositado( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Estadorechazado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Estadorechazado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Estadorechazado( lxVal )
				this.Setear_Estadorechazado( lxVal )
			EndIf
		Else
			This.Setear_Estadorechazado( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Estadobaja_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Estadobaja
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Estadobaja( lxVal )
				this.Setear_Estadobaja( lxVal )
			EndIf
		Else
			This.Setear_Estadobaja( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Estadodevuelto_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Estadodevuelto
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Estadodevuelto( lxVal )
				this.Setear_Estadodevuelto( lxVal )
			EndIf
		Else
			This.Setear_Estadodevuelto( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Estadocomprometido_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Estadocomprometido
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Estadocomprometido( lxVal )
				this.Setear_Estadocomprometido( lxVal )
			EndIf
		Else
			This.Setear_Estadocomprometido( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Estadoenviado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Estadoenviado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Estadoenviado( lxVal )
				this.Setear_Estadoenviado( lxVal )
			EndIf
		Else
			This.Setear_Estadoenviado( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Estadoenviorechazado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Estadoenviorechazado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Estadoenviorechazado( lxVal )
				this.Setear_Estadoenviorechazado( lxVal )
			EndIf
		Else
			This.Setear_Estadoenviorechazado( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Importancia_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Importancia
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Importancia( lxVal )
				this.ValidarDominio_Numericononegativo( lxVal )
				this.Setear_Importancia( lxVal )
			EndIf
		Else
			This.Setear_Importancia( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Estadoentransito_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Estadoentransito
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Estadoentransito( lxVal )
				this.Setear_Estadoentransito( lxVal )
			EndIf
		Else
			This.Setear_Estadoentransito( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Estadoencustodia_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Estadoencustodia
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Estadoencustodia( lxVal )
				this.Setear_Estadoencustodia( lxVal )
			EndIf
		Else
			This.Setear_Estadoencustodia( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Basededatos_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Basededatos
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Basededatos( lxVal )
				this.Setear_Basededatos( lxVal )
			EndIf
		Else
			This.Setear_Basededatos( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaimpo( txVal as variant ) as void

		this.Fechaimpo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechatransferencia( txVal as variant ) as void

		this.Fechatransferencia = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechamodificacionfw( txVal as variant ) as void

		this.Fechamodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaexpo( txVal as variant ) as void

		this.Fechaexpo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fechaaltafw( txVal as variant ) as void

		this.Fechaaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Basededatosaltafw( txVal as variant ) as void

		this.Basededatosaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Basededatosmodificacionfw( txVal as variant ) as void

		this.Basededatosmodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horaaltafw( txVal as variant ) as void

		this.Horaaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Estadotransferencia( txVal as variant ) as void

		this.Estadotransferencia = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horaexpo( txVal as variant ) as void

		this.Horaexpo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Versionaltafw( txVal as variant ) as void

		this.Versionaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Zadsfw( txVal as variant ) as void

		this.Zadsfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Versionmodificacionfw( txVal as variant ) as void

		this.Versionmodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Usuariomodificacionfw( txVal as variant ) as void

		this.Usuariomodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Usuarioaltafw( txVal as variant ) as void

		this.Usuarioaltafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horaimpo( txVal as variant ) as void

		this.Horaimpo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Horamodificacionfw( txVal as variant ) as void

		this.Horamodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Seriealtafw( txVal as variant ) as void

		this.Seriealtafw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Seriemodificacionfw( txVal as variant ) as void

		this.Seriemodificacionfw = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Observacion( txVal as variant ) as void

		this.Observacion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Estadoencartera( txVal as variant ) as void

		this.Estadoencartera = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Estadoentregado( txVal as variant ) as void

		this.Estadoentregado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Descripcion( txVal as variant ) as void

		this.Descripcion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Estadocobrado( txVal as variant ) as void

		this.Estadocobrado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Estadodepositado( txVal as variant ) as void

		this.Estadodepositado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Estadorechazado( txVal as variant ) as void

		this.Estadorechazado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Estadobaja( txVal as variant ) as void

		this.Estadobaja = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Estadodevuelto( txVal as variant ) as void

		this.Estadodevuelto = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Estadocomprometido( txVal as variant ) as void

		this.Estadocomprometido = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Estadoenviado( txVal as variant ) as void

		this.Estadoenviado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Estadoenviorechazado( txVal as variant ) as void

		this.Estadoenviorechazado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Importancia( txVal as variant ) as void

		this.Importancia = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Estadoentransito( txVal as variant ) as void

		this.Estadoentransito = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Estadoencustodia( txVal as variant ) as void

		this.Estadoencustodia = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Basededatos( txVal as variant ) as void

		this.Basededatos = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaimpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechatransferencia( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechamodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaexpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fechaaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Basededatosaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Basededatosmodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horaaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Estadotransferencia( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horaexpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Versionaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Zadsfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Versionmodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Usuariomodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Usuarioaltafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horaimpo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Horamodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Seriealtafw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Seriemodificacionfw( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Observacion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Estadoencartera( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Estadoentregado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Descripcion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Estadocobrado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Estadodepositado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Estadorechazado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Estadobaja( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Estadodevuelto( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Estadocomprometido( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Estadoenviado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Estadoenviorechazado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Importancia( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Estadoentransito( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Estadoencustodia( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Basededatos( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Imputacion_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Imputacion ) = 'O' or isnull( this.Imputacion ) )
					this.Imputacion = _Screen.zoo.instanciarentidad( 'Impdirval' )
					this.Imputacion.lEsSubEntidad = .t.
					this.enlazar( 'Imputacion.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Imputacion.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Imputacion.NUMERO # this.Imputacion_PK
						this.Imputacion.NUMERO = this.Imputacion_PK
					endif
				endif
			endif
		endif
		return this.Imputacion
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_concepto_desde_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_concepto_desde ) = 'O' or isnull( this.F_concepto_desde ) )
					this.F_concepto_desde = _Screen.zoo.instanciarentidad( 'Conceptocaja' )
					this.F_concepto_desde.lEsSubEntidad = .t.
					this.enlazar( 'F_concepto_desde.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_concepto_desde.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_concepto_desde.CODIGO # this.F_concepto_desde_PK
						this.F_concepto_desde.CODIGO = this.F_concepto_desde_PK
					endif
				endif
			endif
		endif
		return this.F_concepto_desde
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_concepto_hasta_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_concepto_hasta ) = 'O' or isnull( this.F_concepto_hasta ) )
					this.F_concepto_hasta = _Screen.zoo.instanciarentidad( 'Conceptocaja' )
					this.F_concepto_hasta.lEsSubEntidad = .t.
					this.enlazar( 'F_concepto_hasta.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_concepto_hasta.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_concepto_hasta.CODIGO # this.F_concepto_hasta_PK
						this.F_concepto_hasta.CODIGO = this.F_concepto_hasta_PK
					endif
				endif
			endif
		endif
		return this.F_concepto_hasta
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_clasificacion_desde_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_clasificacion_desde ) = 'O' or isnull( this.F_clasificacion_desde ) )
					this.F_clasificacion_desde = _Screen.zoo.instanciarentidad( 'Clasificacionconceptocaja' )
					this.F_clasificacion_desde.lEsSubEntidad = .t.
					this.enlazar( 'F_clasificacion_desde.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_clasificacion_desde.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_clasificacion_desde.CODIGO # this.F_clasificacion_desde_PK
						this.F_clasificacion_desde.CODIGO = this.F_clasificacion_desde_PK
					endif
				endif
			endif
		endif
		return this.F_clasificacion_desde
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_clasificacion_hasta_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_clasificacion_hasta ) = 'O' or isnull( this.F_clasificacion_hasta ) )
					this.F_clasificacion_hasta = _Screen.zoo.instanciarentidad( 'Clasificacionconceptocaja' )
					this.F_clasificacion_hasta.lEsSubEntidad = .t.
					this.enlazar( 'F_clasificacion_hasta.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_clasificacion_hasta.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_clasificacion_hasta.CODIGO # this.F_clasificacion_hasta_PK
						this.F_clasificacion_hasta.CODIGO = this.F_clasificacion_hasta_PK
					endif
				endif
			endif
		endif
		return this.F_clasificacion_hasta
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_cuentabancaria_desde_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_cuentabancaria_desde ) = 'O' or isnull( this.F_cuentabancaria_desde ) )
					this.F_cuentabancaria_desde = _Screen.zoo.instanciarentidad( 'Cuentabancaria' )
					this.F_cuentabancaria_desde.lEsSubEntidad = .t.
					this.enlazar( 'F_cuentabancaria_desde.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_cuentabancaria_desde.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_cuentabancaria_desde.CODIGO # this.F_cuentabancaria_desde_PK
						this.F_cuentabancaria_desde.CODIGO = this.F_cuentabancaria_desde_PK
					endif
				endif
			endif
		endif
		return this.F_cuentabancaria_desde
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_cuentabancaria_hasta_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_cuentabancaria_hasta ) = 'O' or isnull( this.F_cuentabancaria_hasta ) )
					this.F_cuentabancaria_hasta = _Screen.zoo.instanciarentidad( 'Cuentabancaria' )
					this.F_cuentabancaria_hasta.lEsSubEntidad = .t.
					this.enlazar( 'F_cuentabancaria_hasta.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_cuentabancaria_hasta.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_cuentabancaria_hasta.CODIGO # this.F_cuentabancaria_hasta_PK
						this.F_cuentabancaria_hasta.CODIGO = this.F_cuentabancaria_hasta_PK
					endif
				endif
			endif
		endif
		return this.F_cuentabancaria_hasta
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Plandecuentas_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Plandecuentas ) = 'O' or isnull( this.Plandecuentas ) )
					this.Plandecuentas = _Screen.zoo.instanciarentidad( 'Plandecuentas' )
					this.Plandecuentas.lEsSubEntidad = .t.
					this.enlazar( 'Plandecuentas.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Plandecuentas.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Plandecuentas.CODIGO # this.Plandecuentas_PK
						this.Plandecuentas.CODIGO = this.Plandecuentas_PK
					endif
				endif
			endif
		endif
		return this.Plandecuentas
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_sucursal_desde_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_sucursal_desde ) = 'O' or isnull( this.F_sucursal_desde ) )
					this.F_sucursal_desde = _Screen.zoo.instanciarentidad( 'Sucursal' )
					this.F_sucursal_desde.lEsSubEntidad = .t.
					this.enlazar( 'F_sucursal_desde.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_sucursal_desde.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_sucursal_desde.CODIGO # this.F_sucursal_desde_PK
						this.F_sucursal_desde.CODIGO = this.F_sucursal_desde_PK
					endif
				endif
			endif
		endif
		return this.F_sucursal_desde
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_sucursal_hasta_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_sucursal_hasta ) = 'O' or isnull( this.F_sucursal_hasta ) )
					this.F_sucursal_hasta = _Screen.zoo.instanciarentidad( 'Sucursal' )
					this.F_sucursal_hasta.lEsSubEntidad = .t.
					this.enlazar( 'F_sucursal_hasta.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_sucursal_hasta.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_sucursal_hasta.CODIGO # this.F_sucursal_hasta_PK
						this.F_sucursal_hasta.CODIGO = this.F_sucursal_hasta_PK
					endif
				endif
			endif
		endif
		return this.F_sucursal_hasta
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_tiposucursal_desde_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_tiposucursal_desde ) = 'O' or isnull( this.F_tiposucursal_desde ) )
					this.F_tiposucursal_desde = _Screen.zoo.instanciarentidad( 'Tiposucursal' )
					this.F_tiposucursal_desde.lEsSubEntidad = .t.
					this.enlazar( 'F_tiposucursal_desde.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_tiposucursal_desde.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_tiposucursal_desde.CODIGO # this.F_tiposucursal_desde_PK
						this.F_tiposucursal_desde.CODIGO = this.F_tiposucursal_desde_PK
					endif
				endif
			endif
		endif
		return this.F_tiposucursal_desde
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function F_tiposucursal_hasta_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.F_tiposucursal_hasta ) = 'O' or isnull( this.F_tiposucursal_hasta ) )
					this.F_tiposucursal_hasta = _Screen.zoo.instanciarentidad( 'Tiposucursal' )
					this.F_tiposucursal_hasta.lEsSubEntidad = .t.
					this.enlazar( 'F_tiposucursal_hasta.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'F_tiposucursal_hasta.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.F_tiposucursal_hasta.CODIGO # this.F_tiposucursal_hasta_PK
						this.F_tiposucursal_hasta.CODIGO = this.F_tiposucursal_hasta_PK
					endif
				endif
			endif
		endif
		return this.F_tiposucursal_hasta
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Limpiar( tlForzar as boolean ) as void
		local loError as Exception
		with this
			Try
				.lLimpiando = .t.
				dodefault( tlForzar )
				.LimpiarFlag()

				.Fechaimpo = ctod( '  /  /    ' )
				.Fechatransferencia = ctod( '  /  /    ' )
				.Fechamodificacionfw = ctod( '  /  /    ' )
				.Fechaexpo = ctod( '  /  /    ' )
				.Fechaaltafw = ctod( '  /  /    ' )
				.Basededatosaltafw = []
				.Basededatosmodificacionfw = []
				.Horaaltafw = []
				.Estadotransferencia = []
				.Horaexpo = []
				.Versionaltafw = []
				.Zadsfw = []
				.Versionmodificacionfw = []
				.Usuariomodificacionfw = []
				.Usuarioaltafw = []
				.Horaimpo = []
				.Horamodificacionfw = []
				.Seriealtafw = []
				.Seriemodificacionfw = []
				.Observacion = []
				.Imputacion_PK = 0
				if .EsNuevo() and !.VerificarContexto( 'CB' )
					.NUMERO = .oNumeraciones.ObtenerNumero('NUMERO')
				else
					.NUMERO = iif( vartype( this.NUMERO ) = 'C', '', 0 )
				endif
				.Estadoencartera = .F.
				.Estadoentregado = .F.
				.Descripcion = []
				.Estadocobrado = .F.
				.F_concepto_desde_PK = []
				.Estadodepositado = .F.
				.F_concepto_hasta_PK = []
				.Estadorechazado = .F.
				.F_clasificacion_desde_PK = []
				.Estadobaja = .F.
				.F_clasificacion_hasta_PK = []
				.Estadodevuelto = .F.
				.F_cuentabancaria_desde_PK = []
				.Estadocomprometido = .F.
				.F_cuentabancaria_hasta_PK = []
				.Estadoenviado = .F.
				.Estadoenviorechazado = .F.
				.Plandecuentas_PK = []
				.Importancia = 0
				.Estadoentransito = .F.
				.Estadoencustodia = .F.
				.F_sucursal_desde_PK = []
				.F_sucursal_hasta_PK = []
				.F_tiposucursal_desde_PK = []
				.F_tiposucursal_hasta_PK = []
				.Basededatos = []
				.LimpiarAtributosVirtuales()
				.oAD.Limpiar()
			catch to loError
				goServicios.Errores.LevantarExcepcion( loError )
			finally
				.lLimpiando = .f.
				if tlForzar
				else
					.SetearValoresSugeridos()
				endif
			EndTry
		endwith
	endfunc
	*--------------------------------------------------------------------------------------------------------
	Function SetearValoresSugeridos() as Void
		With This
			.lEstaSeteandoValorSugerido = .T.
			If .EsNuevo()
				if !this.lEsSubEntidad
				if this.oColeccionVSFW.Buscar( "Fecha" )
					lcValorSugeridoFecha = this.oColeccionVSFW.Item[ "Fecha" ]
					&lcValorSugeridoFecha
				endif
				if this.oColeccionVSFW.Buscar( "Listadeprecios" )
					lcValorSugeridoListaDePrecios = this.oColeccionVSFW.Item[ "Listadeprecios" ]
					&lcValorSugeridoListaDePrecios
				endif
				for each ValorSugeridoPorEntidadSaltoDeCampo in this.oColeccionVS
					&ValorSugeridoPorEntidadSaltoDeCampo
				endfor
				for each ValorSugeridoDeFramework in this.oColeccionVSFW
					if ( upper( alltrim( ValorSugeridoDeFramework ) ) == ".VALORSUGERIDOFWLISTADEPRECIOS()" and !empty( this.ListaDePrecios_PK )) or ;
					   ( upper( alltrim( ValorSugeridoDeFramework ) ) == ".VALORSUGERIDOFWFECHA()" and !empty( this.Fecha ))
					else
						&ValorSugeridoDeFramework
					endif
				endfor
			EndIf
				endif
			.lEstaSeteandoValorSugerido = .F.
		EndWith
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoObservacion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPDIRCAJ", "", "Observacion" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Observacion' )
						.Observacion = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Observaciones para la entidad Imputación de concepto a cuenta contable." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoImputacion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPDIRCAJ", "", "Imputacion" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Imputacion_PK' )
						.Imputacion_PK = lvValorSugeridoDefinidoPorElUsuario
						.Imputacion.NUMERO = .Imputacion_PK
					endif
				endif
			Catch to loError
				.Imputacion_PK=0
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Imputación para la entidad Imputación de concepto a cuenta contable." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoEstadoencartera() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPDIRCAJ", "", "Estadoencartera" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Estadoencartera' )
						.Estadoencartera = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo En cartera para la entidad Imputación de concepto a cuenta contable." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoEstadoentregado() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPDIRCAJ", "", "Estadoentregado" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Estadoentregado' )
						.Estadoentregado = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Entregado para la entidad Imputación de concepto a cuenta contable." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoDescripcion() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPDIRCAJ", "", "Descripcion" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Descripcion' )
						.Descripcion = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Descripción para la entidad Imputación de concepto a cuenta contable." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoEstadocobrado() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPDIRCAJ", "", "Estadocobrado" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Estadocobrado' )
						.Estadocobrado = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Cobrado para la entidad Imputación de concepto a cuenta contable." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_concepto_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPDIRCAJ", "", "F_concepto_desde" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_concepto_desde_PK' )
						.F_concepto_desde_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_concepto_desde.CODIGO = .F_concepto_desde_PK
					endif
				endif
			Catch to loError
				.F_concepto_desde_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Concepto para la entidad Imputación de concepto a cuenta contable." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoEstadodepositado() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPDIRCAJ", "", "Estadodepositado" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Estadodepositado' )
						.Estadodepositado = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Depositado para la entidad Imputación de concepto a cuenta contable." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_concepto_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPDIRCAJ", "", "F_concepto_hasta" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_concepto_hasta_PK' )
						.F_concepto_hasta_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_concepto_hasta.CODIGO = .F_concepto_hasta_PK
					endif
				else
					.ValorSugeridoFWF_concepto_hasta()
				endif
			Catch to loError
				.F_concepto_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Concepto para la entidad Imputación de concepto a cuenta contable." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_concepto_hasta() as void
		with this
			try
				.F_concepto_hasta_PK = 'ZZZZZZZZZZ'
			Catch to loError
				.F_concepto_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoEstadorechazado() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPDIRCAJ", "", "Estadorechazado" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Estadorechazado' )
						.Estadorechazado = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Rechazado para la entidad Imputación de concepto a cuenta contable." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_clasificacion_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPDIRCAJ", "", "F_clasificacion_desde" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_clasificacion_desde_PK' )
						.F_clasificacion_desde_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_clasificacion_desde.CODIGO = .F_clasificacion_desde_PK
					endif
				endif
			Catch to loError
				.F_clasificacion_desde_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Clasificación para la entidad Imputación de concepto a cuenta contable." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoEstadobaja() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPDIRCAJ", "", "Estadobaja" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Estadobaja' )
						.Estadobaja = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Dado de baja para la entidad Imputación de concepto a cuenta contable." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_clasificacion_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPDIRCAJ", "", "F_clasificacion_hasta" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_clasificacion_hasta_PK' )
						.F_clasificacion_hasta_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_clasificacion_hasta.CODIGO = .F_clasificacion_hasta_PK
					endif
				else
					.ValorSugeridoFWF_clasificacion_hasta()
				endif
			Catch to loError
				.F_clasificacion_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Clasificación para la entidad Imputación de concepto a cuenta contable." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_clasificacion_hasta() as void
		with this
			try
				.F_clasificacion_hasta_PK = 'ZZZZZZZZZZ'
			Catch to loError
				.F_clasificacion_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoEstadodevuelto() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPDIRCAJ", "", "Estadodevuelto" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Estadodevuelto' )
						.Estadodevuelto = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Devuelto para la entidad Imputación de concepto a cuenta contable." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_cuentabancaria_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPDIRCAJ", "", "F_cuentabancaria_desde" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_cuentabancaria_desde_PK' )
						.F_cuentabancaria_desde_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_cuentabancaria_desde.CODIGO = .F_cuentabancaria_desde_PK
					endif
				endif
			Catch to loError
				.F_cuentabancaria_desde_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Cuenta bancaria para la entidad Imputación de concepto a cuenta contable." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoEstadocomprometido() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPDIRCAJ", "", "Estadocomprometido" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Estadocomprometido' )
						.Estadocomprometido = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Comprometido para la entidad Imputación de concepto a cuenta contable." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_cuentabancaria_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPDIRCAJ", "", "F_cuentabancaria_hasta" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_cuentabancaria_hasta_PK' )
						.F_cuentabancaria_hasta_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_cuentabancaria_hasta.CODIGO = .F_cuentabancaria_hasta_PK
					endif
				else
					.ValorSugeridoFWF_cuentabancaria_hasta()
				endif
			Catch to loError
				.F_cuentabancaria_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Cuenta bancaria para la entidad Imputación de concepto a cuenta contable." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_cuentabancaria_hasta() as void
		with this
			try
				.F_cuentabancaria_hasta_PK = 'ZZZZZ'
			Catch to loError
				.F_cuentabancaria_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoEstadoenviado() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPDIRCAJ", "", "Estadoenviado" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Estadoenviado' )
						.Estadoenviado = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Enviado para la entidad Imputación de concepto a cuenta contable." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoEstadoenviorechazado() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPDIRCAJ", "", "Estadoenviorechazado" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Estadoenviorechazado' )
						.Estadoenviorechazado = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Envío rechazado para la entidad Imputación de concepto a cuenta contable." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoPlandecuentas() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPDIRCAJ", "", "Plandecuentas" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Plandecuentas_PK' )
						.Plandecuentas_PK = lvValorSugeridoDefinidoPorElUsuario
						.Plandecuentas.CODIGO = .Plandecuentas_PK
					endif
				endif
			Catch to loError
				.Plandecuentas_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Cuenta para la entidad Imputación de concepto a cuenta contable." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoImportancia() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPDIRCAJ", "", "Importancia" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "N"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Importancia' )
						.Importancia = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Importancia para la entidad Imputación de concepto a cuenta contable." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es numérico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoEstadoentransito() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPDIRCAJ", "", "Estadoentransito" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Estadoentransito' )
						.Estadoentransito = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo En tránsito para la entidad Imputación de concepto a cuenta contable." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoEstadoencustodia() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPDIRCAJ", "", "Estadoencustodia" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "L"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Estadoencustodia' )
						.Estadoencustodia = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo En custodia para la entidad Imputación de concepto a cuenta contable." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es lógico." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_sucursal_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPDIRCAJ", "", "F_sucursal_desde" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_sucursal_desde_PK' )
						.F_sucursal_desde_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_sucursal_desde.CODIGO = .F_sucursal_desde_PK
					endif
				endif
			Catch to loError
				.F_sucursal_desde_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Sucursal para la entidad Imputación de concepto a cuenta contable." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_sucursal_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPDIRCAJ", "", "F_sucursal_hasta" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_sucursal_hasta_PK' )
						.F_sucursal_hasta_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_sucursal_hasta.CODIGO = .F_sucursal_hasta_PK
					endif
				else
					.ValorSugeridoFWF_sucursal_hasta()
				endif
			Catch to loError
				.F_sucursal_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Sucursal para la entidad Imputación de concepto a cuenta contable." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_sucursal_hasta() as void
		with this
			try
				.F_sucursal_hasta_PK = 'ZZZZZZZZZZ'
			Catch to loError
				.F_sucursal_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_tiposucursal_desde() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPDIRCAJ", "", "F_tiposucursal_desde" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_tiposucursal_desde_PK' )
						.F_tiposucursal_desde_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_tiposucursal_desde.CODIGO = .F_tiposucursal_desde_PK
					endif
				endif
			Catch to loError
				.F_tiposucursal_desde_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Tipo sucursal para la entidad Imputación de concepto a cuenta contable." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoF_tiposucursal_hasta() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPDIRCAJ", "", "F_tiposucursal_hasta" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'F_tiposucursal_hasta_PK' )
						.F_tiposucursal_hasta_PK = lvValorSugeridoDefinidoPorElUsuario
						.F_tiposucursal_hasta.CODIGO = .F_tiposucursal_hasta_PK
					endif
				else
					.ValorSugeridoFWF_tiposucursal_hasta()
				endif
			Catch to loError
				.F_tiposucursal_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Tipo sucursal para la entidad Imputación de concepto a cuenta contable." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoFWF_tiposucursal_hasta() as void
		with this
			try
				.F_tiposucursal_hasta_PK = 'ZZZZZZZZZZ'
			Catch to loError
				.F_tiposucursal_hasta_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
			endtry 
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoBasededatos() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "IMPDIRCAJ", "", "Basededatos" )
			if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
				if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
					try
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Basededatos' )
						.Basededatos = lvValorSugeridoDefinidoPorElUsuario
					catch to loError
						loEx = newobject("zooexception", "zooexception.prg" )
						loEx.Grabar( loError )
						loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
						loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Base de datos / agrupamiento para la entidad Imputación de concepto a cuenta contable." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
						goServicios.Errores.LevantarExcepcion( loEx )
					endtry
				endif
			endif
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function EventoEstaSeteandoValorSugerido( lcAtributo as String ) as Void
	endfunc

	*-----------------------------------------------------------------------------------------
	function CargaManual() as Boolean
		return !this.lLimpiando and !this.lCargando and !this.lDestroy
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarDominio_Fecha( txVal as variant ) as void

		if This.oValidacionDominios.ValidarDominio_Fecha( txVal )
		else
			goServicios.Errores.LevantarExcepcion( This.oValidacionDominios.ObtenerInformacion() )
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarDominio_Numericononegativo( txVal as variant ) as void

		if This.oValidacionDominios.ValidarDominio_Numericononegativo( txVal )
		else
			goServicios.Errores.LevantarExcepcion( This.oValidacionDominios.ObtenerInformacion() )
		endif
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Destroy()

		this.lDestroy = .t.
		if vartype( this.oNumeraciones ) == "O" and !isnull( this.oNumeraciones )
			this.oNumeraciones.Release()
		endif
		this.oNumeraciones = null
		use in select( 'c_IMPDIRCAJ' )
		dodefault()
	endfunc
	*--------------------------------------------------------------------------------------------------------
	function LimpiarAtributosVirtuales() as void
		dodefault()
		with this
		endwith
	endfunc
	
	*--------------------------------------------------------------------------------------------------------
	function ObtenerAtributosCombinacion() as object
		local loColRetorno as object
		
		loColRetorno = _screen.zoo.CrearObjeto( 'zooColeccion' )
		return loColRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerDetalleaInsertar() as detalle of detalle.prg
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerAtributoDetalleaInsertar() as detalle of detalle.prg
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function TieneDetallesConPrePantalla() as Boolean
		local llRetorno as Boolean
		llRetorno = .f.
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombreDetallesConPrePantalla() as ZooColeccion of ZooColeccion.prg
		local loRetorno as ZooColeccion OF ZooColeccion.prg
		loRetorno = _screen.zoo.CrearObjeto("ZooColeccion")
		return loRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function AsignarValoresSugeridosAtributosClaveCandidataNoVisibles() as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function AsignarValoresSugeridosAtributosClaveDeBusquedaNoVisibles() as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerCodigoErrorParaValidacionTimestamp() as Integer
		return goServicios.Errores.ObtenerCodigoErrorParaValidacionTimestamp()
	endfunc

enddefine