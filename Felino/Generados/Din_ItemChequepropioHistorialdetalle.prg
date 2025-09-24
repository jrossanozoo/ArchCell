
define class Din_ItemCHEQUEPROPIOHistorialdetalle as ItemActivo of ItemActivo.prg

	cNombre = 'CHEQUEPROPIO'
	VendedorDescripcion = []
	CuentaBancariaDescripcion = []
	ProveedorDescripcion = []
	ClienteDescripcion = []
	NROITEM = 0
	Serie = []
	IdentificadorEntidadComprobante = []
	Version = []
	CodigoComprobante = []
	Proveedor = []
	Vendedor = []
	Cliente = []
	CuentaBancaria_PK = []
	CuentaBancaria = null
	cAtributoPK = 'Codigo'
	Codigo = []
	Fecha = ctod( '  /  /    ' )
	Hora = []
	TipoDeComprobante = 0
	Comprobante = []
	Concepto_PK = []
	Concepto = null
	ConceptoDetalle = []
	Tipo = 0
	CajaEstado = 0
	CajaEstadoDetalle = []
	BaseDeOrigen = []
	Estado = []
	oColeccionVS = null
	oColeccionVSFW = null
	lKitPermiteColorYTalle = .f.
	*-----------------------------------------------------------------------------------------
	function RestaurarGenHabilitar() as Void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		dodefault()
		this.oColeccionVSFW = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		this.oColeccionVS = _screen.zoo.CrearObjeto( 'zoocoleccion' )
		oICol = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugeridoDeUnaEntidadDetalle( 'CHEQUEPROPIO', 'Historialdetalle')
		for each oItmUs in oICol
			this.oColeccionVS.Agregar( '.ValorSugerido' + alltrim(oItmUs.atributo) + '()' )
			try
				this.oColeccionVSFW.Quitar( alltrim( proper( oItmUs.atributo ) ) )
			catch to loError
			endtry
		endfor
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cuentabancaria_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cuentabancaria_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 5, padr( lxVal, 5 ), lxVal )
		this.Cuentabancaria_PK = lxVal

		if this.Validar_Cuentabancaria( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Cuentabancaria_Pk', lxValOld, lxVal  )
			This.Setear_Cuentabancaria( lxVal )
			this.EventoDespuesDeSetear( This, 'Cuentabancaria_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal or empty( this.Cuentabancariadescripcion ) 
				this.Cuentabancariadescripcion = This.CuentaBancaria.Nombre
			endif
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Cuentabancaria_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Concepto_PK_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Concepto_PK
		local lxVal as Variant
		local loSugerido as Object
		
		lxVal = txVal
		lxVal = iif( len( lxVal ) < 10, padr( lxVal, 10 ), lxVal )
		this.Concepto_PK = lxVal

		if this.Validar_Concepto( lxVal, lxValOld )
			this.EventoAntesDeSetear( This, 'Concepto_Pk', lxValOld, lxVal  )
			This.Setear_Concepto( lxVal )
			this.EventoDespuesDeSetear( This, 'Concepto_Pk', lxValOld, lxVal  )
			If lxValOld != lxVal or empty( this.Conceptodetalle ) 
				this.Conceptodetalle = This.Concepto.Descripcion
			endif
			If lxValOld != lxVal
				If This.PuedeEjecutarHaCambiado()
					this.HaCambiado( 'Concepto_Pk', This )
				Endif
			EndIf
		endif
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cuentabancaria( txVal as variant ) as void

		this.Cuentabancaria.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Concepto( txVal as variant ) as void

		this.Concepto.CODIGO = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cuentabancaria( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Concepto( txVal as variant, txValOld as variant ) as Boolean

		Return This.CargaManual() and dodefault( txVal, txValOld )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Vendedordescripcion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Vendedordescripcion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Vendedordescripcion( lxVal )
				this.EventoAntesDeSetear( This, 'Vendedordescripcion', lxValOld, lxVal  )
				this.Setear_Vendedordescripcion( lxVal )
				this.EventoDespuesDeSetear( This, 'Vendedordescripcion', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Vendedordescripcion', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Vendedordescripcion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cuentabancariadescripcion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cuentabancariadescripcion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cuentabancariadescripcion( lxVal )
				this.EventoAntesDeSetear( This, 'Cuentabancariadescripcion', lxValOld, lxVal  )
				this.Setear_Cuentabancariadescripcion( lxVal )
				this.EventoDespuesDeSetear( This, 'Cuentabancariadescripcion', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Cuentabancariadescripcion', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Cuentabancariadescripcion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Proveedordescripcion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Proveedordescripcion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Proveedordescripcion( lxVal )
				this.EventoAntesDeSetear( This, 'Proveedordescripcion', lxValOld, lxVal  )
				this.Setear_Proveedordescripcion( lxVal )
				this.EventoDespuesDeSetear( This, 'Proveedordescripcion', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Proveedordescripcion', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Proveedordescripcion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Clientedescripcion_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Clientedescripcion
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Clientedescripcion( lxVal )
				this.EventoAntesDeSetear( This, 'Clientedescripcion', lxValOld, lxVal  )
				this.Setear_Clientedescripcion( lxVal )
				this.EventoDespuesDeSetear( This, 'Clientedescripcion', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Clientedescripcion', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Clientedescripcion( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Nroitem_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Nroitem
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Nroitem( lxVal )
				this.EventoAntesDeSetear( This, 'Nroitem', lxValOld, lxVal  )
				this.Setear_Nroitem( lxVal )
				this.EventoDespuesDeSetear( This, 'Nroitem', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Nroitem', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Nroitem( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Serie_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Serie
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Serie( lxVal )
				this.EventoAntesDeSetear( This, 'Serie', lxValOld, lxVal  )
				this.Setear_Serie( lxVal )
				this.EventoDespuesDeSetear( This, 'Serie', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Serie', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Serie( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Identificadorentidadcomprobante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Identificadorentidadcomprobante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Identificadorentidadcomprobante( lxVal )
				this.EventoAntesDeSetear( This, 'Identificadorentidadcomprobante', lxValOld, lxVal  )
				this.Setear_Identificadorentidadcomprobante( lxVal )
				this.EventoDespuesDeSetear( This, 'Identificadorentidadcomprobante', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Identificadorentidadcomprobante', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Identificadorentidadcomprobante( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Version_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Version
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Version( lxVal )
				this.EventoAntesDeSetear( This, 'Version', lxValOld, lxVal  )
				this.Setear_Version( lxVal )
				this.EventoDespuesDeSetear( This, 'Version', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Version', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Version( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Codigocomprobante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Codigocomprobante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Codigocomprobante( lxVal )
				this.EventoAntesDeSetear( This, 'Codigocomprobante', lxValOld, lxVal  )
				this.Setear_Codigocomprobante( lxVal )
				this.EventoDespuesDeSetear( This, 'Codigocomprobante', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Codigocomprobante', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Codigocomprobante( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Proveedor_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Proveedor
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Proveedor( lxVal )
				this.EventoAntesDeSetear( This, 'Proveedor', lxValOld, lxVal  )
				this.Setear_Proveedor( lxVal )
				this.EventoDespuesDeSetear( This, 'Proveedor', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Proveedor', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Proveedor( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Vendedor_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Vendedor
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Vendedor( lxVal )
				this.EventoAntesDeSetear( This, 'Vendedor', lxValOld, lxVal  )
				this.Setear_Vendedor( lxVal )
				this.EventoDespuesDeSetear( This, 'Vendedor', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Vendedor', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Vendedor( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cliente_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cliente
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cliente( lxVal )
				this.EventoAntesDeSetear( This, 'Cliente', lxValOld, lxVal  )
				this.Setear_Cliente( lxVal )
				this.EventoDespuesDeSetear( This, 'Cliente', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Cliente', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Cliente( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Fecha_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Fecha
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Fecha( lxVal )
				this.ValidarDominio_Fecha( lxVal )
				this.EventoAntesDeSetear( This, 'Fecha', lxValOld, lxVal  )
				this.Setear_Fecha( lxVal )
				this.EventoDespuesDeSetear( This, 'Fecha', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Fecha', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Fecha( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Hora_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Hora
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Hora( lxVal )
				this.EventoAntesDeSetear( This, 'Hora', lxValOld, lxVal  )
				this.Setear_Hora( lxVal )
				this.EventoDespuesDeSetear( This, 'Hora', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Hora', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Hora( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tipodecomprobante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tipodecomprobante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tipodecomprobante( lxVal )
				this.EventoAntesDeSetear( This, 'Tipodecomprobante', lxValOld, lxVal  )
				this.Setear_Tipodecomprobante( lxVal )
				this.EventoDespuesDeSetear( This, 'Tipodecomprobante', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Tipodecomprobante', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Tipodecomprobante( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Comprobante_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Comprobante
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Comprobante( lxVal )
				this.EventoAntesDeSetear( This, 'Comprobante', lxValOld, lxVal  )
				this.Setear_Comprobante( lxVal )
				this.EventoDespuesDeSetear( This, 'Comprobante', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Comprobante', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Comprobante( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Conceptodetalle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Conceptodetalle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Conceptodetalle( lxVal )
				this.EventoAntesDeSetear( This, 'Conceptodetalle', lxValOld, lxVal  )
				this.Setear_Conceptodetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Conceptodetalle', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Conceptodetalle', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Conceptodetalle( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Tipo_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Tipo
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Tipo( lxVal )
				this.EventoAntesDeSetear( This, 'Tipo', lxValOld, lxVal  )
				this.Setear_Tipo( lxVal )
				this.EventoDespuesDeSetear( This, 'Tipo', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Tipo', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Tipo( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cajaestado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cajaestado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cajaestado( lxVal )
				this.EventoAntesDeSetear( This, 'Cajaestado', lxValOld, lxVal  )
				this.Setear_Cajaestado( lxVal )
				this.EventoDespuesDeSetear( This, 'Cajaestado', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Cajaestado', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Cajaestado( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cajaestadodetalle_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Cajaestadodetalle
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Cajaestadodetalle( lxVal )
				this.EventoAntesDeSetear( This, 'Cajaestadodetalle', lxValOld, lxVal  )
				this.Setear_Cajaestadodetalle( lxVal )
				this.EventoDespuesDeSetear( This, 'Cajaestadodetalle', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Cajaestadodetalle', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Cajaestadodetalle( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Basedeorigen_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Basedeorigen
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Basedeorigen( lxVal )
				this.EventoAntesDeSetear( This, 'Basedeorigen', lxValOld, lxVal  )
				this.Setear_Basedeorigen( lxVal )
				this.EventoDespuesDeSetear( This, 'Basedeorigen', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Basedeorigen', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Basedeorigen( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Estado_Assign( txVal as variant ) as void

		Local lxValOld As Variant
		lxValOld = this.Estado
		local lxVal as Variant
		lxVal = txVal

		if This.CargaManual()
			if this.Validar_Estado( lxVal )
				this.EventoAntesDeSetear( This, 'Estado', lxValOld, lxVal  )
				this.Setear_Estado( lxVal )
				this.EventoDespuesDeSetear( This, 'Estado', lxValOld, lxVal  )
				If lxValOld != lxVal
					If This.PuedeEjecutarHaCambiado()
						this.HaCambiado( 'Estado', This )
					Endif
				EndIf
			EndIf
		Else
			This.Setear_Estado( lxVal ) 
		EndIf
		dodefault( lxVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Vendedordescripcion( txVal as variant ) as void

		this.Vendedordescripcion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cuentabancariadescripcion( txVal as variant ) as void

		this.Cuentabancariadescripcion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Proveedordescripcion( txVal as variant ) as void

		this.Proveedordescripcion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Clientedescripcion( txVal as variant ) as void

		this.Clientedescripcion = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Nroitem( txVal as variant ) as void

		this.Nroitem = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Serie( txVal as variant ) as void

		this.Serie = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Identificadorentidadcomprobante( txVal as variant ) as void

		this.Identificadorentidadcomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Version( txVal as variant ) as void

		this.Version = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Codigocomprobante( txVal as variant ) as void

		this.Codigocomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Proveedor( txVal as variant ) as void

		this.Proveedor = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Vendedor( txVal as variant ) as void

		this.Vendedor = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cliente( txVal as variant ) as void

		this.Cliente = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Fecha( txVal as variant ) as void

		this.Fecha = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Hora( txVal as variant ) as void

		this.Hora = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipodecomprobante( txVal as variant ) as void

		this.Tipodecomprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Comprobante( txVal as variant ) as void

		this.Comprobante = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Conceptodetalle( txVal as variant ) as void

		this.Conceptodetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Tipo( txVal as variant ) as void

		this.Tipo = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cajaestado( txVal as variant ) as void

		this.Cajaestado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Cajaestadodetalle( txVal as variant ) as void

		this.Cajaestadodetalle = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Basedeorigen( txVal as variant ) as void

		this.Basedeorigen = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Setear_Estado( txVal as variant ) as void

		this.Estado = txVal
		dodefault( txVal )

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Vendedordescripcion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cuentabancariadescripcion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Proveedordescripcion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Clientedescripcion( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Nroitem( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Serie( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Identificadorentidadcomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Version( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Codigocomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Proveedor( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Vendedor( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cliente( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Fecha( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Hora( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipodecomprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Comprobante( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Conceptodetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Tipo( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cajaestado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Cajaestadodetalle( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Basedeorigen( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Validar_Estado( txVal as variant ) as Boolean

		Return dodefault( txVal ) 

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Cuentabancaria_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Cuentabancaria ) = 'O' or isnull( this.Cuentabancaria ) )
					this.Cuentabancaria = _Screen.zoo.instanciarentidad( 'Cuentabancaria' )
					this.Cuentabancaria.lEsSubEntidad = .t.
					this.enlazar( 'Cuentabancaria.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Cuentabancaria.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Cuentabancaria.CODIGO # this.Cuentabancaria_PK
						this.Cuentabancaria.CODIGO = this.Cuentabancaria_PK
					endif
				endif
			endif
		endif
		return this.Cuentabancaria
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Concepto_Access() as variant
		if this.ldestroy
		else
			if This.lInstanciarSubEntidadaDemanda
				if ( !vartype( this.Concepto ) = 'O' or isnull( this.Concepto ) )
					this.Concepto = _Screen.zoo.instanciarentidad( 'Conceptocaja' )
					this.Concepto.lEsSubEntidad = .t.
					this.enlazar( 'Concepto.EventoObtenerLogueo', 'inyectarLogueo' )
					this.enlazar( 'Concepto.EventoObtenerInformacion', 'inyectarInformacion' )
				endif
				if !this.lBuscandoCodigo
					if this.Concepto.CODIGO # this.Concepto_PK
						this.Concepto.CODIGO = this.Concepto_PK
					endif
				endif
			endif
		endif
		return this.Concepto
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function Limpiar( tlForzar as boolean ) as void
		local loError as Exception
		with this
			Try
				.lLimpiando = .t.
				dodefault( tlForzar )
				.LimpiarFlag()

				.Vendedordescripcion = []
				.Cuentabancariadescripcion = []
				.Proveedordescripcion = []
				.Clientedescripcion = []
				.Serie = []
				.Identificadorentidadcomprobante = []
				.Version = []
				.Codigocomprobante = []
				.Proveedor = []
				.Vendedor = []
				.Cliente = []
				.Cuentabancaria_PK = []
				.Codigo = []
				.Fecha = ctod( '  /  /    ' )
				.Hora = []
				.Tipodecomprobante = 0
				.Comprobante = []
				.Concepto_PK = []
				.Conceptodetalle = []
				.Tipo = 0
				.Cajaestado = 0
				.Cajaestadodetalle = []
				.Basedeorigen = []
				.Estado = []
				.LimpiarAtributosVirtuales()
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
			.lEstaSeteandoValorSugerido = .F.
		EndWith
	EndFunc
	*--------------------------------------------------------------------------------------------------------
	Function ValorSugeridoConcepto() as void
		local lcExpresionValorSugeridoDefinidoPorElUsuario as String, lvValorSugeridoDefinidoPorElUsuario as Variant, loError as Object, loEx as Object, loExTipoDato as Object
		lcExpresionValorSugeridoDefinidoPorElUsuario = null
		with this
			try
				lcExpresionValorSugeridoDefinidoPorElUsuario = goServicios.SaltosDeCampoYValoresSugeridos.ObtenerValorSugerido( "CHEQUEPROPIO", "Historialdetalle", "Concepto" )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					if !empty( lcExpresionValorSugeridoDefinidoPorElUsuario )
						lvValorSugeridoDefinidoPorElUsuario = &lcExpresionValorSugeridoDefinidoPorElUsuario
						if vartype( lvValorSugeridoDefinidoPorElUsuario ) # "C"
							loExTipoDato = newobject("zooexception", "zooexception.prg" )
							loExTipoDato.Message = "Error de tipo de dato."
							loExTipoDato.Throw()
						endif
						This.EventoEstaSeteandoValorSugerido( 'Concepto_PK' )
						.Concepto_PK = lvValorSugeridoDefinidoPorElUsuario
						.Concepto.CODIGO = .Concepto_PK
					endif
				endif
			Catch to loError
				.Concepto_PK=[]
				loEx = newobject("zooexception", "zooexception.prg" )
				loEx.Grabar( loError )
				if !isnull( lcExpresionValorSugeridoDefinidoPorElUsuario )
					loEx.AgregarInformacion( iif( type( "loError.UserValue.Message" ) == "C", loError.UserValue.Message, loError.Message ) )
					
					loEx.AgregarInformacion( "Se produjo un error al intentar asignar el valor sugerido " + lcExpresionValorSugeridoDefinidoPorElUsuario + " del atributo Concepto para el detalle Historial de interacciones." + chr( 10 ) + "Verifique el valor especificado en la entidad Comportamiento de atributos." + chr( 10 ) + "El tipo de dato del atributo es caracter." )
					goServicios.Errores.LevantarExcepcion( loEx )
				endif
			endtry 
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
	function Destroy()

		this.lDestroy = .t.
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ValidarAtributoComponente( txVal as variant, tcAtributo as string ) as boolean
		local llRetorno as Boolean
		llRetorno = .T.
		
		
		Return llRetorno
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
	function ValidarExistenciaCamposFijos() as Boolean
		Local llRetorno as boolean
		llRetorno = .t.

		return llRetorno

	endfunc

	*--------------------------------------------------------------------------------------------------------
	function habilitar( tlHabilitar as boolean ) as void
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerNombre() as String
		return [ITEMCHEQUEPROPIOHIST]
	endfunc

enddefine