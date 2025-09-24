
define class Din_DetalleSELECHEQUEAINSERTARDetallechequesainsertar as detalle of detalle.prg


	nCantidadItems = 999
	cNombre = 'Detallechequesainsertar'
	cEtiqueta = 'Cheques filtrados'
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
			
				.NROITEM = this.Item[ tnItem ].NROITEM
			
				.CodigoValor = this.Item[ tnItem ].CodigoValor
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodigoValor', .CodigoValor )
			
				.FechaDePago = this.Item[ tnItem ].FechaDePago
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'FechaDePago', .FechaDePago )
			
				.Moneda = this.Item[ tnItem ].Moneda
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Moneda', .Moneda )
			
				.Cliente_PK = this.Item[ tnItem ].Cliente_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Cliente_PK', .Cliente_PK )
			
				.ClienteDetalle = this.Item[ tnItem ].ClienteDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'ClienteDetalle', .ClienteDetalle )
			
				.Numero = this.Item[ tnItem ].Numero
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Numero', .Numero )
			
				.EntidadFinanciera_PK = this.Item[ tnItem ].EntidadFinanciera_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'EntidadFinanciera_PK', .EntidadFinanciera_PK )
			
				.EntidadFinancieraDetalle = this.Item[ tnItem ].EntidadFinancieraDetalle
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'EntidadFinancieraDetalle', .EntidadFinancieraDetalle )
			
				.FechaEmision = this.Item[ tnItem ].FechaEmision
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'FechaEmision', .FechaEmision )
			
				.NumeroInt = this.Item[ tnItem ].NumeroInt
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroInt', .NumeroInt )
			
				.CodigoTributarioLibrador = this.Item[ tnItem ].CodigoTributarioLibrador
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'CodigoTributarioLibrador', .CodigoTributarioLibrador )
			
				.Monto = this.Item[ tnItem ].Monto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Monto', .Monto )
			
				.Seleccionado = this.Item[ tnItem ].Seleccionado
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Seleccionado', .Seleccionado )
			
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
			.NROITEM = this.oItem.NROITEM
			.CodigoValor = this.oItem.CodigoValor
			.FechaDePago = this.oItem.FechaDePago
			.Moneda = this.oItem.Moneda
			.Cliente_PK = this.oItem.Cliente_PK
			.ClienteDetalle = this.oItem.ClienteDetalle
			.Numero = this.oItem.Numero
			.EntidadFinanciera_PK = this.oItem.EntidadFinanciera_PK
			.EntidadFinancieraDetalle = this.oItem.EntidadFinancieraDetalle
			.FechaEmision = this.oItem.FechaEmision
			.NumeroInt = this.oItem.NumeroInt
			.CodigoTributarioLibrador = this.oItem.CodigoTributarioLibrador
			.Monto = this.oItem.Monto
			.Seleccionado = this.oItem.Seleccionado
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
			.Item[ lnItem ].NROITEM = .oItem.NROITEM
			.Item[ lnItem ].CodigoValor = .oItem.CodigoValor
			.Item[ lnItem ].FechaDePago = .oItem.FechaDePago
			.Item[ lnItem ].Moneda = .oItem.Moneda
			.Item[ lnItem ].Cliente_PK = .oItem.Cliente_PK
			.Item[ lnItem ].ClienteDetalle = .oItem.ClienteDetalle
			.Item[ lnItem ].Numero = .oItem.Numero
			.Item[ lnItem ].EntidadFinanciera_PK = .oItem.EntidadFinanciera_PK
			.Item[ lnItem ].EntidadFinancieraDetalle = .oItem.EntidadFinancieraDetalle
			.Item[ lnItem ].FechaEmision = .oItem.FechaEmision
			.Item[ lnItem ].NumeroInt = .oItem.NumeroInt
			.Item[ lnItem ].CodigoTributarioLibrador = .oItem.CodigoTributarioLibrador
			.Item[ lnItem ].Monto = .oItem.Monto
			.Item[ lnItem ].Seleccionado = .oItem.Seleccionado
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemSELECHEQUEAINSERTARDetallechequesainsertar' )
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

		select c_Detallechequesainsertar
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Codigo = c_Detallechequesainsertar.Codigo
			loItem.NROITEM = c_Detallechequesainsertar.NROITEM
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

		return llRetorno

	endfunc


	*-----------------------------------------------------------------------------------------
	Function ValidarFormatoAtributos() as boolean
	local lnLargoEntero as integer, lnValorDelDecimal as integer, lnLargoDecimal as integer, llRetorno as boolean, lnI as Integer

		llRetorno = dodefault()
		for lni = 1 to this.Count
			
			if vartype( this.Item[lni].CODIGO) = 'C'
				if len( alltrim( this.Item[lni].CODIGO )) <= 10
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGO ))) + ' Máxima:10), en el detalle ' + this.cEtiqueta + '.' )
				Endif
			else
				llRetorno = .F.
				this.AgregarInformacion( 'El tipo de dato para el atributo CODIGO del item ' + transform( lni ) + ' no es el correcto, en el detalle ' + this.cEtiqueta + '.')
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
		toItemDestino.Nroitem = toItemOrigen.Nroitem
		toItemDestino.Codigovalor = toItemOrigen.Codigovalor
		toItemDestino.Fechadepago = toItemOrigen.Fechadepago
		toItemDestino.Moneda = toItemOrigen.Moneda
		toItemDestino.Cliente_PK = toItemOrigen.Cliente_PK
		toItemDestino.Clientedetalle = toItemOrigen.Clientedetalle
		toItemDestino.Numero = toItemOrigen.Numero
		toItemDestino.Entidadfinanciera_PK = toItemOrigen.Entidadfinanciera_PK
		toItemDestino.Entidadfinancieradetalle = toItemOrigen.Entidadfinancieradetalle
		toItemDestino.Fechaemision = toItemOrigen.Fechaemision
		toItemDestino.Numeroint = toItemOrigen.Numeroint
		toItemDestino.Codigotributariolibrador = toItemOrigen.Codigotributariolibrador
		toItemDestino.Monto = toItemOrigen.Monto
		toItemDestino.Seleccionado = toItemOrigen.Seleccionado
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


enddefine

*-----------------------------------------------------------------------------------------
define class ItemAuxiliar as custom

	Codigo = []
	Nroitem = 0
	Codigovalor = []
	Fechadepago = ctod( '  /  /    ' )
	Moneda = []
	Cliente_PK = []
	Clientedetalle = []
	Numero = 0
	Entidadfinanciera_PK = []
	Entidadfinancieradetalle = []
	Fechaemision = ctod( '  /  /    ' )
	Numeroint = 0
	Codigotributariolibrador = []
	Monto = 0
	Seleccionado = .F.
	NroItem = 0

enddefine