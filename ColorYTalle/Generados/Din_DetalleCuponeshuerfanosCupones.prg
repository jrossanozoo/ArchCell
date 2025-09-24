
define class Din_DetalleCUPONESHUERFANOSCupones as DetalleCupon of DetalleCupon.Prg


	nCantidadItems = 999
	cNombre = 'Cupones'
	cEtiqueta = 'Cupones'
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
			
				.Interno = this.Item[ tnItem ].Interno
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Interno', .Interno )
			
				.Moneda_PK = this.Item[ tnItem ].Moneda_PK
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Moneda_PK', .Moneda_PK )
			
				.AutorizacionPOS = this.Item[ tnItem ].AutorizacionPOS
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'AutorizacionPOS', .AutorizacionPOS )
			
				.NumeroInterno = this.Item[ tnItem ].NumeroInterno
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroInterno', .NumeroInterno )
			
				.NumeroCupon = this.Item[ tnItem ].NumeroCupon
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'NumeroCupon', .NumeroCupon )
			
				.Lote = this.Item[ tnItem ].Lote
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Lote', .Lote )
			
				.Valor = this.Item[ tnItem ].Valor
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Valor', .Valor )
			
				.Monto = this.Item[ tnItem ].Monto
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Monto', .Monto )
			
				.Porcentaje = this.Item[ tnItem ].Porcentaje
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Porcentaje', .Porcentaje )
			
				.Recargo = this.Item[ tnItem ].Recargo
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Recargo', .Recargo )
			
				.Total = this.Item[ tnItem ].Total
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Total', .Total )
			
				.Cuotas = this.Item[ tnItem ].Cuotas
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Cuotas', .Cuotas )
			
				.TipoCupon = this.Item[ tnItem ].TipoCupon
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'TipoCupon', .TipoCupon )
			
				.Fecha = this.Item[ tnItem ].Fecha
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Fecha', .Fecha )
			
				.Hora = this.Item[ tnItem ].Hora
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Hora', .Hora )
			
				.POS = this.Item[ tnItem ].POS
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'POS', .POS )
			
				.Incluido = this.Item[ tnItem ].Incluido
				llVacio = llVacio and this.VerificarSiElAtributoEstaVacio( 'Incluido', .Incluido )
			
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
			.Interno = this.oItem.Interno
			.Moneda_PK = this.oItem.Moneda_PK
			.AutorizacionPOS = this.oItem.AutorizacionPOS
			.NumeroInterno = this.oItem.NumeroInterno
			.NumeroCupon = this.oItem.NumeroCupon
			.Lote = this.oItem.Lote
			.Valor = this.oItem.Valor
			.Monto = this.oItem.Monto
			.Porcentaje = this.oItem.Porcentaje
			.Recargo = this.oItem.Recargo
			.Total = this.oItem.Total
			.Cuotas = this.oItem.Cuotas
			.TipoCupon = this.oItem.TipoCupon
			.Fecha = this.oItem.Fecha
			.Hora = this.oItem.Hora
			.POS = this.oItem.POS
			.Incluido = this.oItem.Incluido
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
			.Item[ lnItem ].Interno = .oItem.Interno
			.Item[ lnItem ].Moneda_PK = .oItem.Moneda_PK
			.Item[ lnItem ].AutorizacionPOS = .oItem.AutorizacionPOS
			.Item[ lnItem ].NumeroInterno = .oItem.NumeroInterno
			.Item[ lnItem ].NumeroCupon = .oItem.NumeroCupon
			.Item[ lnItem ].Lote = .oItem.Lote
			.Item[ lnItem ].Valor = .oItem.Valor
			.Item[ lnItem ].Monto = .oItem.Monto
			.Item[ lnItem ].Porcentaje = .oItem.Porcentaje
			.Item[ lnItem ].Recargo = .oItem.Recargo
			.Item[ lnItem ].Total = .oItem.Total
			.Item[ lnItem ].Cuotas = .oItem.Cuotas
			.Item[ lnItem ].TipoCupon = .oItem.TipoCupon
			.Item[ lnItem ].Fecha = .oItem.Fecha
			.Item[ lnItem ].Hora = .oItem.Hora
			.Item[ lnItem ].POS = .oItem.POS
			.Item[ lnItem ].Incluido = .oItem.Incluido
		else
			goServicios.Errores.LevantarExcepcion( .ObtenerInformacion() )
		endif
	endwith
	endfunc

	*--------------------------------------------------------------------------------------------------------
	function oItem_Access() as variant
		if !this.ldestroy and ( !vartype( this.oItem ) = 'O' or isnull( this.oItem ) )
			this.oItem = _Screen.zoo.crearobjeto( 'Din_ItemCUPONESHUERFANOSCupones' )
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

		select c_Cupones
		lcFiltro = this.ObtenerFiltro()
		scan for &lcFiltro
			loItem = createobject('ItemAuxiliar')

			loItem.Codigo = c_Cupones.Codigo
			loItem.NROITEM = c_Cupones.NROITEM
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
				if len( alltrim( this.Item[lni].CODIGO )) <= 38
				else
					llRetorno = .F.
					this.AgregarInformacion( 'La longitud del valor del atributo CODIGO del item ' + transform( lni ) + ' es mayor a la permitida (Actual:' + transform( len( alltrim( this.Item[lni].CODIGO ))) + ' Máxima:38), en el detalle ' + this.cEtiqueta + '.' )
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
		toItemDestino.Interno = toItemOrigen.Interno
		toItemDestino.Moneda_PK = toItemOrigen.Moneda_PK
		toItemDestino.Autorizacionpos = toItemOrigen.Autorizacionpos
		toItemDestino.Numerointerno = toItemOrigen.Numerointerno
		toItemDestino.Numerocupon = toItemOrigen.Numerocupon
		toItemDestino.Lote = toItemOrigen.Lote
		toItemDestino.Valor = toItemOrigen.Valor
		toItemDestino.Monto = toItemOrigen.Monto
		toItemDestino.Porcentaje = toItemOrigen.Porcentaje
		toItemDestino.Recargo = toItemOrigen.Recargo
		toItemDestino.Total = toItemOrigen.Total
		toItemDestino.Cuotas = toItemOrigen.Cuotas
		toItemDestino.Tipocupon = toItemOrigen.Tipocupon
		toItemDestino.Fecha = toItemOrigen.Fecha
		toItemDestino.Hora = toItemOrigen.Hora
		toItemDestino.Pos = toItemOrigen.Pos
		toItemDestino.Incluido = toItemOrigen.Incluido
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
	Interno = []
	Moneda_PK = []
	Autorizacionpos = .F.
	Numerointerno = []
	Numerocupon = 0
	Lote = 0
	Valor = []
	Monto = 0
	Porcentaje = 0
	Recargo = 0
	Total = 0
	Cuotas = 0
	Tipocupon = []
	Fecha = ctod( '  /  /    ' )
	Hora = []
	Pos = []
	Incluido = .F.
	NroItem = 0

enddefine