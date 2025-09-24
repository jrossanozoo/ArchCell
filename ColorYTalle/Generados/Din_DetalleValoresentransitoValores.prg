
define class Din_DetalleVALORESENTRANSITOValores as detalle of detalle.prg


	nCantidadItems = 999
	cNombre = 'Valores'
	cEtiqueta = 'Detalle de valores'
	cMensajeErrorUnicidad = 'La columna  no admite valores repetidos.'
	cNombreVisual = ''

	*--------------------------------------------------------------------------------------------------------
	function Inicializar() as boolean
		dodefault()
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Protected Function _CargarItem( tnItem as integer )
		Local loEx as Excepcion, llVacio as Boolean
		if tnItem <= 0
			loEx = Newobject( 'ZooException', 'ZooException.prg' )
			With loEx
				.Message = 'El item está fuera del rango'
				.Grabar()
				.Throw()
			EndWith
		EndIf
		With this.oItem
			Try
				.lCargando = .t.
				.NroItem = tnItem
				llVacio = .t.
				.Codigo = this.Item[ tnItem ].Codigo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Codigo', .Codigo )
			
				.Cotiza = this.Item[ tnItem ].Cotiza
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Cotiza', .Cotiza )
			
				.CodigoCheque_PK = this.Item[ tnItem ].CodigoCheque_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodigoCheque_PK', .CodigoCheque_PK )
			
				.Tipo = this.Item[ tnItem ].Tipo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Tipo', .Tipo )
			
				.CodigoChequePropio_PK = this.Item[ tnItem ].CodigoChequePropio_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodigoChequePropio_PK', .CodigoChequePropio_PK )
			
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.Valor_PK = this.Item[ tnItem ].Valor_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Valor_PK', .Valor_PK )
			
				.ValorDetalle = this.Item[ tnItem ].ValorDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ValorDetalle', .ValorDetalle )
			
				.NumeroInterno = this.Item[ tnItem ].NumeroInterno
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroInterno', .NumeroInterno )
			
				.FechaEmision = this.Item[ tnItem ].FechaEmision
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'FechaEmision', .FechaEmision )
			
				.FechaPago = this.Item[ tnItem ].FechaPago
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'FechaPago', .FechaPago )
			
				.EstadoEnOrigen = this.Item[ tnItem ].EstadoEnOrigen
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'EstadoEnOrigen', .EstadoEnOrigen )
			
				.Monto = this.Item[ tnItem ].Monto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Monto', .Monto )
			
				.lCargando = .f.
				if llVacio
					this.oItem.SetearValoresSugeridos()
				endif
			Finally
				.lCargando = .f.
			EndTry
		endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function AplanarItem() as Object
		local loRetorno as object
		loRetorno = createobject('ItemAuxiliar')

		with loRetorno
			.Codigo = this.oItem.Codigo
			.Cotiza = this.oItem.Cotiza
			.CodigoCheque_PK = this.oItem.CodigoCheque_PK
			.Tipo = this.oItem.Tipo
			.CodigoChequePropio_PK = this.oItem.CodigoChequePropio_PK
			.NROITEM = this.oItem.NROITEM
			.Valor_PK = this.oItem.Valor_PK
			.ValorDetalle = this.oItem.ValorDetalle
			.NumeroInterno = this.oItem.NumeroInterno
			.FechaEmision = this.oItem.FechaEmision
			.FechaPago = this.oItem.FechaPago
			.EstadoEnOrigen = this.oItem.EstadoEnOrigen
			.Monto = this.oItem.Monto
			.NroItem = iif( this.oItem.NroItem = 0, this.Count + 1, this.oItem.NroItem )
		endwith

		return loRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function Modificar() as void
	local lnItem as integer, loEx as Exception

	with this
		if .ValidarItem()
			lnItem = .oItem.NroItem
			if lnItem <= 0
				.AgregarInformacion( 'Debe cargar un item para poder modificar' )
				goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
			endif

			if .oItem.ValidarExistenciaCamposFijos()
			else
				.oItem.Limpiar( .t. )
			endif

			.oItem.NroItem = lnItem
			.Item[ lnItem ].Codigo = .oItem.Codigo
			.Item[ lnItem ].Cotiza = .oItem.Cotiza
			.Item[ lnItem ].CodigoCheque_PK = .oItem.CodigoCheque_PK
			.Item[ lnItem ].Tipo = .oItem.Tipo
			.Item[ lnItem ].CodigoChequePropio_PK = .oItem.CodigoChequePropio_PK
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].Valor_PK = .oItem.Valor_PK
			.Item[ lnItem ].ValorDetalle = .oItem.ValorDetalle
			.Item[ lnItem ].NumeroInterno = .oItem.NumeroInterno
			.Item[ lnItem ].FechaEmision = .oItem.FechaEmision
			.Item[ lnItem ].FechaPago = .oItem.FechaPago
			.Item[ lnItem ].EstadoEnOrigen = .oItem.EstadoEnOrigen
			.Item[ lnItem ].Monto = .oItem.Monto
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemVALORESENTRANSITOValores' )
			this.enlazar( 'oItem.EventoObtenerLogueo', 'inyectarLogueo' )
			this.enlazar( 'oItem.EventoObtenerInformacion', 'inyectarInformacion' )
			this.oItem.inicializar()
			bindevent( this.oItem, 'EventoDespuesDeSetear', this, 'ValidarCantidadDeItemsEnDetalle' )
		endif
		return this.oItem
	endfunc

	*--------------------------------------------------------------------------------------------------------
	Function Cargar() as Void
		local loItem as object, lnI as integer, lcClave as string, lcFiltro as String 
		lnI = 1

		select c_Valores
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Codigo = c_Valores.Codigo
			loItem.Cotiza = c_Valores.Cotiza
			loItem.CodigoCheque_PK = c_Valores.CodigoCheque
			loItem.Tipo = c_Valores.Tipo
			loItem.CodigoChequePropio_PK = c_Valores.CodigoChequePropio
			loItem.NROITEM = c_Valores.NROITEM
			loItem.Valor_PK = c_Valores.Valor
			loItem.ValorDetalle = c_Valores.ValorDetalle
			loItem.NumeroInterno = c_Valores.NumeroInterno
			loItem.FechaEmision = goLibrerias.ObtenerFechaFormateada( c_Valores.FechaEmision )
			loItem.FechaPago = goLibrerias.ObtenerFechaFormateada( c_Valores.FechaPago )
			loItem.EstadoEnOrigen = c_Valores.EstadoEnOrigen
			loItem.Monto = c_Valores.Monto
			loItem.NroItem = lnI 
			this.AgregarItemPlano( loItem )
			lnI = lnI + 1
		endscan

		this.CambioSumarizado()

	endfunc


	*--------------------------------------------------------------------------------------------------------
	function ValidarExistenciaCamposFijosItemPlano( tnItem as integer ) as Boolean
		Local llRetorno as boolean
		llRetorno = .t.

		if  empty( this.item[ tnItem ].Valor_PK ) 
			llRetorno = .F.
		endif 
		return llRetorno

	endfunc


	*-----------------------------------------------------------------------------------------
	Function ValidarFormatoAtributos() as boolean
	local lnLargoEntero as integer, lnValorDelDecimal as integer, lnLargoDecimal as integer, llRetorno as boolean, lnI as Integer

		llRetorno = dodefault()
		for lni = 1 to this.Count
			
			if vartype( this.Item[lni].CODIGO) = 'C'
				if len( alltrim( this.Item[lni].CODIGO )) <= 20
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGO ))) + ' Máxima:20), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].COTIZA) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].COTIZA ) ) ) 
				lnValorDelDecimal = this.Item[lni].COTIZA - int( this.Item[lni].COTIZA )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo COTIZA del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo COTIZA del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CODIGOCHEQUE_PK) = 'C'
				if len( alltrim( this.Item[lni].CODIGOCHEQUE_PK )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGOCHEQUE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGOCHEQUE_PK ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGOCHEQUE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].TIPO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].TIPO ) ) ) 
				lnValorDelDecimal = this.Item[lni].TIPO - int( this.Item[lni].TIPO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 2
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo TIPO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:2), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo TIPO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].CODIGOCHEQUEPROPIO_PK) = 'C'
				if len( alltrim( this.Item[lni].CODIGOCHEQUEPROPIO_PK )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGOCHEQUEPROPIO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGOCHEQUEPROPIO_PK ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGOCHEQUEPROPIO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NROITEM) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].NROITEM ) ) ) 
				lnValorDelDecimal = this.Item[lni].NROITEM - int( this.Item[lni].NROITEM )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 5
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo NROITEM del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:5), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NROITEM del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].VALOR_PK) = 'C'
				if len( alltrim( this.Item[lni].VALOR_PK )) <= 5
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo VALOR del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].VALOR_PK ))) + ' Máxima:5), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo VALOR del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].VALORDETALLE) = 'C'
				if len( alltrim( this.Item[lni].VALORDETALLE )) <= 40
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo VALORDETALLE del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].VALORDETALLE ))) + ' Máxima:40), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo VALORDETALLE del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].NUMEROINTERNO) = 'C'
				if len( alltrim( this.Item[lni].NUMEROINTERNO )) <= 15
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo NUMEROINTERNO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].NUMEROINTERNO ))) + ' Máxima:15), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo NUMEROINTERNO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if inlist(vartype( this.Item[lni].FECHAEMISION),'D','T')
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo FECHAEMISION del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if inlist(vartype( this.Item[lni].FECHAPAGO),'D','T')
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo FECHAPAGO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].ESTADOENORIGEN) = 'C'
				if len( alltrim( this.Item[lni].ESTADOENORIGEN )) <= 5
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo ESTADOENORIGEN del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].ESTADOENORIGEN ))) + ' Máxima:5), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo ESTADOENORIGEN del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
			
			if vartype( this.Item[lni].MONTO) = 'N'
				lnLargoEntero = len( transform( int( this.Item[lni].MONTO ) ) ) 
				lnValorDelDecimal = this.Item[lni].MONTO - int( this.Item[lni].MONTO )
				lnLargoDecimal = iif( lnValorDelDecimal = 0, 0, len( transform( lnValorDelDecimal ) ) - 2 )
				if lnLargoEntero <= 13
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud entera del valor del atributo MONTO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform(lnLargoEntero) + ' Máxima:13), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo MONTO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
			Endif
		EndFor
		Return llRetorno 
	Endfunc

	*--------------------------------------------------------------------------------------------------------
	function CrearItemAuxiliar() as Object
		return createobject( 'itemAuxiliar' )
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ClonarItemAuxiliar( tnItem as Integer ) as Object
		loItemOrigen = this.Item[tnItem]
		loRetorno = createobject( 'itemAuxiliar' )
		this.CopiarItemaItem( loItemOrigen, loRetorno ) 

		return loRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function CopiarItemaItem( toItemOrigen as Object, toItemDestino as Object ) as Object
		toItemDestino.Codigo = toItemOrigen.Codigo
		toItemDestino.Cotiza = toItemOrigen.Cotiza
		toItemDestino.Codigocheque_PK = toItemOrigen.Codigocheque_PK
		toItemDestino.Tipo = toItemOrigen.Tipo
		toItemDestino.Codigochequepropio_PK = toItemOrigen.Codigochequepropio_PK
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Valor_PK = toItemOrigen.Valor_PK
		toItemDestino.Valordetalle = toItemOrigen.Valordetalle
		toItemDestino.Numerointerno = toItemOrigen.Numerointerno
		toItemDestino.Fechaemision = toItemOrigen.Fechaemision
		toItemDestino.Fechapago = toItemOrigen.Fechapago
		toItemDestino.Estadoenorigen = toItemOrigen.Estadoenorigen
		toItemDestino.Monto = toItemOrigen.Monto
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function VerificarSiElAtributoEstaVacio( tcAtributo as String, txValor as Variant ) as Boolean
		local llRetorno as boolean
		llRetorno = .t.
		if this.ElAtributoEsVerificableComoVacio( tcAtributo )
			llRetorno = empty( txValor )
		endif
		return llRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ElAtributoEsVerificableComoVacio( tcAtributo as String ) as Boolean
		Return dodefault( tcAtributo ) 
	endfunc

	*--------------------------------------------------------------------------------------------------------
	protected function ObtenerFiltro( ) as String
		local lcRetorno as String
		lcRetorno = '.T.'
		return lcRetorno
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function ObtenerCampoInicialYOBligatorioDelDetalle() as String
	local lcRetorno as string
		lcRetorno = 'Valor_pk'
		return lcRetorno
	endfunc

enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Codigo = []
	Cotiza = 0
	Codigocheque_PK = []
	Tipo = 0
	Codigochequepropio_PK = []
	Nroitem = 0
	Valor_PK = []
	Valordetalle = []
	Numerointerno = []
	Fechaemision = ctod( '  /  /    ' )
	Fechapago = ctod( '  /  /    ' )
	Estadoenorigen = []
	Monto = 0
	NroItem = 0
	lTieneImporteEnRecibido = .f.

enddefine